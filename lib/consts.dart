




import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/theme/style.dart';

Widget sizeVer(double height)  {
  return SizedBox(height: height,);
}

Widget sizeHor(double width) {
  return SizedBox(width: width,);
}

class PageConst {
  static const String editProfilePage = "editProfilePage";
  static const String updatePostPage = "updatePostPage";
  static const String commentPage = "commentPage";
  static const String signInPage = "signInPage";
  static const String signUpPage = "signUpPage";
}

class FirebaseConst {
  static const String users = "users";
  static const String posts = "posts";
  static const String comment = "comment";
  static const String replay = "replay";

}


void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: blueColor,
      textColor: Colors.white,
      fontSize: 16.0);
}