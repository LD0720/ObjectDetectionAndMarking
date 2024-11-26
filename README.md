# Corporatica Task: Camera with AR and Object Detection

This project is a Flutter-based application that integrates ARCore for augmented reality and YOLOv8 for object detection. The app allows users to detect objects using their device's camera and overlay AR markers on detected objects.

---

## Features

- **Object Detection**: Real-time object detection using YOLOv8.
- **AR Integration**: Adds AR markers to detected objects using ARCore and Flutter's AR plugins.
- **Camera Integration**: Live camera feed using the Flutter `camera` package.
- **Cross-Platform**: Supports Android devices.

---

## Installation

### Prerequisites
1. Flutter SDK installed ([Install Flutter](https://flutter.dev/docs/get-started/install)).
2. Android Studio or Visual Studio Code set up for Flutter development.
3. Android device or emulator for testing.

### Clone the Repository
```bash```
git clone https://github.com/your-username/corporatica_task.git
cd corporatica_task
Install Dependencies
Run the following commands to install the required dependencies:

```bash```
flutter pub get
Update the Plugin Namespace (if needed)
Navigate to ~/.pub-cache/hosted/pub.dartlang.org/ar_flutter_plugin-x.x.x/android/build.gradle and add the namespace property to the android block if not present:

```gradle```
android {
    namespace = "com.google.ar.flutter_plugin"
}
Usage
Run the Application:

```bash``
flutter run
Permissions: Ensure the app has camera and AR permissions enabled on your Android device.

##Object Detection and AR:

The app displays a live camera feed.
Detected objects are marked with AR markers in real-time.
##Troubleshooting
Gradle Build Errors: Ensure your build.gradle files align with the required versions of Gradle and Kotlin. See the Gradle Wrapper section.

Namespace Issues: Add a namespace to the ar_flutter_plugin module, as described in the installation steps.

Kotlin Version Mismatch: Update kotlin_version in android/build.gradle to at least 1.8.10.

##Project Structure
```bash```

corporatica_task/
├── android/                 # Android-specific files
├── ios/                     # iOS-specific files (optional)
├── lib/                     # Flutter code
│   ├── main.dart            # Entry point of the app
│   └── UI/
│       └── open_camera.dart # Core implementation of Camera and AR
├── pubspec.yaml             # Project dependencies
└── README.md                # Project documentation
##Dependencies
Flutter
AR Flutter Plugin
Camera
YOLOv8 (via Python integration)
##License
This project is licensed under the MIT License - see the LICENSE file for details.
