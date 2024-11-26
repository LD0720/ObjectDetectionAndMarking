import 'package:corporatica_task/Models/photo_model.dart';
import 'package:hive/hive.dart';

class LocalStorage {
  static const String boxName = 'localImages';

  Box<PhotoModel> get _localImagesBox => Hive.box<PhotoModel>(name: boxName);

  // Add image to local storage
  void addImageToBox(PhotoModel photo) {
    _localImagesBox.put(photo.imageId, photo);
  }

  // Get image from local storage
  PhotoModel? getImage(String imageId) {
    return _localImagesBox.get(imageId);
  }

  // Get all images from local storage
  List<PhotoModel> getAllImages() {
    return _localImagesBox
        .getAll(_localImagesBox.keys)
        .whereType<PhotoModel>()
        .toList();
  }

  // Delete an image from local storage
  void deleteImageFromLocal(String imageId) {
    _localImagesBox.delete(imageId);
  }
}
