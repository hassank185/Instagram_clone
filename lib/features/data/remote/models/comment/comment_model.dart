import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';

class CommentModel extends CommentEntity {
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createAt;
  final List<String>? likes;
  final num? totalReplays;
  final String? commentId;
  final String? postId;
  final String? creatorUid;

  CommentModel({
   this.likes,
    this.postId,
    this.creatorUid,
    this.description,
    this.username,
    this.userProfileUrl,
    this.createAt,
    this.commentId,
    this.totalReplays
  }): super (
      likes: likes,
      postId: postId,
      creatorUid:creatorUid,
    description: description,
          username: username,
      userProfileUrl: userProfileUrl,
      createAt: createAt,
    commentId: commentId,
      totalReplays: totalReplays,
  );

  factory CommentModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
      commentId: snapshot['commentId'],
      totalReplays: snapshot['totalReplays'],
      createAt: snapshot['createAt'],
      username: snapshot['username'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      userProfileUrl: snapshot['userProfileUrl'],
      likes: List.from(snap.get("likes")),
    );
  }
  Map<String, dynamic> toJson() => {
    "createAt": createAt,
    "creatorUid": creatorUid,
    "username": username,
    "description": description,
    "postId": postId,
    "userProfileUrl": userProfileUrl,
    "likes": likes,
    "commentId": commentId,
    "totalReplays": totalReplays,
  };
}