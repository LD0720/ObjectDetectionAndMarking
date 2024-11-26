import 'package:corporatica_task/Models/photo_model.dart';
import 'package:corporatica_task/Storage/local_storage.dart';
import 'package:corporatica_task/UI/single_photo.dart';
import 'package:flutter/material.dart';

class LocalPhotos extends StatefulWidget {
  const LocalPhotos({Key? key}) : super(key: key);

  @override
  _LocalPhotosState createState() => _LocalPhotosState();
}

class _LocalPhotosState extends State<LocalPhotos> {
  List<PhotoModel> _photos = [];

  @override
  void initState() {
    super.initState();
    _loadLocalPhotos();
  }

  void _loadLocalPhotos() {
    _photos = LocalStorage().getAllImages();
    setState(() {});
  }

  void _refresh() {
    _loadLocalPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Photos'),
      ),
      body: _photos.isEmpty
          ? const Center(child: Text('No photos available'))
          : ListView.builder(
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return SinglePhoto(
                  photo: _photos[index],
                  onDelete: _refresh,
                  onUpload: _refresh,
                );
              },
            ),
    );
  }
}
