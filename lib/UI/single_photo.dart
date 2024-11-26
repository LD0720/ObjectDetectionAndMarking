import 'dart:io';
import 'package:corporatica_task/Models/photo_model.dart';
import 'package:corporatica_task/Storage/firebase_storage.dart';
import 'package:corporatica_task/Storage/local_storage.dart';
import 'package:flutter/material.dart';

class SinglePhoto extends StatelessWidget {
  final PhotoModel photo;
  final VoidCallback? onDelete;
  final VoidCallback? onUpload;
  final bool isGlobal;

  const SinglePhoto({
    super.key,
    required this.photo,
    this.onDelete,
    this.onUpload,
    this.isGlobal = false,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseStorageService _firebaseService = FirebaseStorageService();
    final LocalStorage _localStorage = LocalStorage();

    return Card(
      child: Column(
        children: [
          isGlobal
              ? Image.network(photo.imagePath)
              : Image.file(File(photo.imagePath)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!isGlobal && !photo.upload)
                IconButton(
                  icon: const Icon(Icons.cloud_upload),
                  onPressed: () async {
                    await _firebaseService.uploadPhoto(photo);
                    // photo.upload = true;
                    _localStorage.addImageToBox(photo);
                    if (onUpload != null) onUpload!();
                  },
                ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  if (isGlobal) {
                    await _firebaseService.deletePhoto(photo.imageId);
                  } else {
                    _localStorage.deleteImageFromLocal(photo.imageId);
                  }
                  if (onDelete != null) onDelete!();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
