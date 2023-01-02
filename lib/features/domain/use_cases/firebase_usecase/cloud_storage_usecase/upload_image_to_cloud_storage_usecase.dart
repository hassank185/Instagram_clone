




import 'dart:io';

import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';

class UploadImageToCloudStorage{
  final FirebaseRepository repository;

  UploadImageToCloudStorage({required this.repository});
  Future<String> call(File? file,bool? isPost, String childName) {
    return repository.uploadImageToCloudStorage(file,isPost,childName);
  }
}