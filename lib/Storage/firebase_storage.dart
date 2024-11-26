import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:corporatica_task/Models/photo_model.dart';

class FirebaseStorageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload photo to Firebase Storage and save metadata to Firestore
  Future<bool> uploadPhoto(PhotoModel photo) async {
    try {
      // Upload image file to Firebase Storage
      File imageFile = File(photo.imagePath);
      TaskSnapshot snapshot =
          await _storage.ref('photos/${photo.imageId}.jpg').putFile(imageFile);

      // Get download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save metadata to Firestore
      await _firestore.collection('photos').doc(photo.imageId).set({
        'imageId': photo.imageId,
        'imagePath': downloadUrl,
        'upload': true,
      });

      return true;
    } catch (e) {
      print('Error uploading photo: $e');
      return false;
    }
  }

  // Delete photo from Firebase Storage and Firestore
  Future<bool> deletePhoto(String imageId) async {
    try {
      // Delete from Storage
      await _storage.ref('photos/$imageId.jpg').delete();

      // Delete from Firestore
      await _firestore.collection('photos').doc(imageId).delete();

      return true;
    } catch (e) {
      print('Error deleting photo: $e');
      return false;
    }
  }

  // Get all photos from Firestore
  Future<List<PhotoModel>> getAllPhotos() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('photos').get();

      List<PhotoModel> photos = snapshot.docs.map((doc) {
        return PhotoModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return photos;
    } catch (e) {
      print('Error fetching photos: $e');
      return [];
    }
  }
}
