import 'package:equatable/equatable.dart';
import 'dart:io';

class UserEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? username;
  final String? name;
  final String? bio;
  final String? website;
  final num? totalPosts;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final String? password;
  final String? otherUid;
  final File? imageFile;

  UserEntity({
    this.imageFile,
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.password,
    this.otherUid,
    this.email,
    this.totalPosts,
  });

  @override
  List<Object?> get props => [
        uid,
        username,
        name,
        bio,
        website,
        profileUrl,
        followers,
        following,
        totalFollowers,
        totalFollowing,
        password,
        otherUid,
        email,
    totalPosts,
    imageFile,
      ];
}
