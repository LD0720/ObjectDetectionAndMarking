import 'package:corporatica_task/UI/global_photos.dart';
import 'package:corporatica_task/UI/local_photos.dart';
import 'package:corporatica_task/UI/open_camera.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AR Detection System"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => _navigateTo(context, const OpenCamera()),
                child: const Text("Open Camera")),
            ElevatedButton(
                onPressed: () => _navigateTo(context, const LocalPhotos()),
                child: const Text("Stored Images")),
            ElevatedButton(
                onPressed: () => _navigateTo(context, const GlobalPhotos()),
                child: const Text("Uploaded Images")),
          ],
        ),
      ),
    );
  }
}
