import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:camera/camera.dart';
import 'package:corporatica_task/camera_access.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class OpenCamera extends StatefulWidget {
  const OpenCamera({Key? key}) : super(key: key);

  @override
  _OpenCameraState createState() => _OpenCameraState();
}

class _OpenCameraState extends material.State<OpenCamera> {
  // Camera variables
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  bool _isDetecting = false;
  List<dynamic> _recognitions = [];
  final CameraAccess _cameraAccess = CameraAccess();
  final Uuid _uuid = const Uuid();
  // List to keep track of AR nodes
  final List<ARNode> _arNodes = [];

  double _imageHeight = 0;
  double _imageWidth = 0;

  // AR variables
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;

  // To limit detection frequency
  int _frameCount = 0;
  static const int _detectionInterval = 3;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _cameraController = CameraController(
        _cameras[0],
        ResolutionPreset.medium, // Adjust resolution for performance
        enableAudio: false,
      );

      await _cameraController.initialize();

      // Get image dimensions
      _imageHeight = _cameraController.value.previewSize?.height ?? 0;
      _imageWidth = _cameraController.value.previewSize?.width ?? 0;

      setState(() {
        _isCameraInitialized = true;
      });

      // Start image stream for live detection
      _cameraController.startImageStream((CameraImage image) {
        _frameCount++;
        if (_frameCount % _detectionInterval != 0)
          return; // Limit detection frequency

        if (!_isDetecting) {
          _isDetecting = true;

          _cameraAccess.detectObjects(image).then((recognitions) {
            setState(() {
              _recognitions = recognitions;
            });

            // Update AR markers based on recognitions
            _updateArMarkers();

            _isDetecting = false;
          }).catchError((error) {
            print('Error during object detection: $error');
            _isDetecting = false;
          });
        }
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  // Callback when AR session is initialized
  void _onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
  ) {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;

    // Optional: Configure session or object manager callbacks
    arSessionManager?.onPlaneOrPointTap = _handleOnPlaneTap;
  }

  // Handle taps on planes or points
  void _handleOnPlaneTap(List<ARHitTestResult> hits) {
    if (hits.isNotEmpty) {
      final hit = hits.first;
      final nodeName = 'user_tapped_node_${_uuid.v4()}';

      // Decompose the transformation matrix to get position and rotation
      final vm.Quaternion rotation = vm.Quaternion.identity();
      final vm.Vector3 position = vm.Vector3.zero();
      final vm.Vector3 scale = vm.Vector3.zero();
      hit.worldTransform.decompose(scale, rotation, position);

      // Create an AR node with a sphere shape
      ARNode node = ARNode(
          name: nodeName,
          type: NodeType.localGLTF2,
          position: position,
          rotation: vm.Vector4(rotation.x, rotation.y, rotation.z, rotation.w),
          uri: 'assets/scene.gltf');
      arObjectManager!.addNode(node);
    }
  }

  // Update AR markers based on object detection
  void _updateArMarkers() async {
    if (arObjectManager == null) return;

    // Remove previous nodes
    if (_arNodes.isNotEmpty) {
      for (var node in _arNodes) {
        await arObjectManager!.removeNode(node);
      }
      _arNodes.clear();
    }

    for (var reco in _recognitions) {
      if (reco['rect'] != null &&
          reco['classId'] != null &&
          reco['score'] != null) {
        // Get the center point of the detection rectangle
        double centerX = reco['rect'].left + reco['rect'].width / 2;
        double centerY = reco['rect'].top + reco['rect'].height / 2;

        // Normalize the coordinates based on the camera image dimensions
        double normalizedX = centerX / _imageWidth;
        double normalizedY = centerY / _imageHeight;

        // Convert normalized coordinates to screen coordinates
        var screenSize = material.MediaQuery.of(context).size;
        double screenW = screenSize.width;
        double screenH = screenSize.height;

        double screenX = normalizedX * screenW;
        double screenY = normalizedY * screenH;

        // Define position and rotation manually
        final vm.Vector3 position =
            vm.Vector3(normalizedX, normalizedY, -1.0); // Example z-value
        final vm.Quaternion rotation = vm.Quaternion.identity();

        final nodeName = 'detected_object_${_uuid.v4()}';

        // Create an AR node with a sphere shape
        ARNode node = ARNode(
          name: nodeName,
          type: NodeType.localGLTF2,
          position: position,
          rotation: vm.Vector4(rotation.x, rotation.y, rotation.z, rotation.w),
          uri: 'assets/scene.gltf',
        );

        await arObjectManager!.addNode(node);
        _arNodes.add(node);
      }
    }
  }

  // Capture photo, perform detection, draw boxes, and save
  Future<void> _captureAndSavePhoto() async {
    // ... Your existing code to capture and save photo ...
  }

  @override
  void dispose() {
    _cameraController.dispose();
    arSessionManager?.dispose();
    super.dispose();
  }

  @override
  material.Widget build(material.BuildContext context) {
    if (!_isCameraInitialized) {
      return const material.Scaffold(
        body: material.Center(child: material.CircularProgressIndicator()),
      );
    }

    return material.Scaffold(
      appBar: material.AppBar(title: const material.Text('Camera with AR')),
      body: material.Stack(
        children: [
          // Camera Preview
          material.Positioned.fill(
            child: CameraPreview(_cameraController),
          ),
          // AR View
          material.Positioned.fill(
            child: ARView(
              onARViewCreated: (ARSessionManager, ARObjectManager,
                      ARAnchorManager, ARLocationManager) =>
                  _onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
          ),
          // Capture Button
          material.Align(
            alignment: material.Alignment.bottomCenter,
            child: material.Padding(
              padding: const material.EdgeInsets.all(16.0),
              child: material.ElevatedButton(
                onPressed: _captureAndSavePhoto,
                child: const material.Text('Capture Photo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
