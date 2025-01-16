import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statckmod_app/services/firebase_services.dart';

class ImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<File> _pickImageFromDevice() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw Exception('No image selected');
    }
  }

  Future<void> uploadImage() async {
    final user = await FirebaseAuthService().getCurrentUser();
    final userId = user!.uid;
    // Request permission to access photos

    var status = await Permission.photos.request();
    if (status.isGranted) {
      try {
        // Fetch image from device storage
        File image;
        // Assuming you have a method to pick an image from the device
        image = await _pickImageFromDevice();
        await _storage.ref('user_images/$userId').putFile(image);
      } on FirebaseException catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('Permission denied');
    }
  }

  Future<String?> getImageUrl() async {
    try {
      final user = await FirebaseAuthService().getCurrentUser();
      final userId = user!.uid;
      String downloadURL =
          await _storage.ref('user_images/$userId').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print('Error getting image URL: $e');
      return null;
    }
  }
}
