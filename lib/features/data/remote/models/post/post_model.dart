import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';

class PostModel extends PostEntity {
  final String? postId;
  final String? creatorUid;
  final String? username;
  final String? description;
  final String? postImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  PostModel({
    this.postId,
    this.creatorUid,
    this.username,
    this.description,
    this.postImageUrl,
    this.likes,
    this.totalLikes,
    this.totalComments,
    this.createAt,
    this.userProfileUrl,
  }): super (
    username: username,
    createAt: createAt,
    creatorUid: creatorUid,
    description: description,
    likes: likes,
    postId: postId,
    postImageUrl: postImageUrl,
    totalComments: totalComments,
    totalLikes: totalLikes,
    userProfileUrl: userProfileUrl,
  );

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      createAt: snapshot['createAt'],
      username: snapshot['username'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      postImageUrl: snapshot['postImageUrl'],
      totalComments: snapshot['totalComments'],
      totalLikes: snapshot['totalLikes'],
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
    "postImageUrl": postImageUrl,
    "totalComments": totalComments,
    "totalLikes": totalLikes,
    "userProfileUrl": userProfileUrl,
    "likes": likes,
  };
}