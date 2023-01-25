

import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';

class AppEntity {
  final UserEntity? currentUser;
  final PostEntity? postEntity;

  final String? uid;
  final String? postId;

  AppEntity({this.currentUser, this.postEntity, this.uid, this.postId});
}