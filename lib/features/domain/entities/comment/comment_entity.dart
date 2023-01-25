import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createAt;
  final List<String>? likes;
  final num? totalReplays;
  final String? commentId;
  final String? postId;
  final String? creatorUid;

  CommentEntity({
    this.description,
    this.username,
    this.userProfileUrl,
    this.createAt,
    this.likes,
    this.totalReplays,
    this.commentId,
    this.postId,
    this.creatorUid,
  });

  @override
  List<Object?> get props => [
    description,
    username,
    userProfileUrl,
    createAt,
    likes,
    totalReplays,
    commentId,
    postId,
    creatorUid,
  ];
}
