import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    final filename = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = _storage.ref().child('item_images/$filename.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
