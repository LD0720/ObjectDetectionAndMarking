import 'package:corporatica_task/Models/photo_model.dart';
import 'package:corporatica_task/Storage/firebase_storage.dart';
import 'package:corporatica_task/UI/single_photo.dart';
import 'package:flutter/material.dart';

class GlobalPhotos extends StatefulWidget {
  const GlobalPhotos({Key? key}) : super(key: key);

  @override
  _GlobalPhotosState createState() => _GlobalPhotosState();
}

class _GlobalPhotosState extends State<GlobalPhotos> {
  List<PhotoModel> _photos = [];
  final FirebaseStorageService _firebaseService = FirebaseStorageService();

  @override
  void initState() {
    super.initState();
    _loadGlobalPhotos();
  }

  void _loadGlobalPhotos() async {
    _photos = await _firebaseService.getAllPhotos();
    setState(() {});
  }

  void _refresh() {
    _loadGlobalPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploaded Photos'),
      ),
      body: _photos.isEmpty
          ? const Center(child: Text('No photos available'))
          : ListView.builder(
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return SinglePhoto(
                  photo: _photos[index],
                  onDelete: _refresh,
                  isGlobal: true,
                );
              },
            ),
    );
  }
}
