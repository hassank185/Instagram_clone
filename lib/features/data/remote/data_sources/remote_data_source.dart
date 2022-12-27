


import 'dart:io';

import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signInUser(UserEntity user);

  Future<void> signUpUser(UserEntity user);

  Future<bool> isSignIn();

  Future<void> signOut();

  Stream<List<UserEntity>> getUsers(UserEntity user);

  Stream<List<UserEntity>> getSingleUsers(String uid);

  Future<String> getCurrentUid();

  Future<void> createUser(UserEntity user);

  Future<void> updateUser(UserEntity user);

  Future<String> uploadImageToCloudStorage(File? file, bool isPost, String? childName);

  //Post feature

  Future<void> createPost(PostEntity post);
  Stream<List<PostEntity>> readPosts(PostEntity post);
  Future<void> updatePost(PostEntity post);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);

}