

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/cloud_storage_usecase/upload_image_to_cloud_storage_usecase.dart';
import 'package:instagram_clone/features/presentation/manager/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:instagram_clone/theme/style.dart';
import 'package:uuid/uuid.dart';
import 'package:instagram_clone/injection_container.dart'as di;


class UploadPostMainWidget extends StatefulWidget {
  final UserEntity currentUser;
  const UploadPostMainWidget ({Key? key,required this.currentUser}) : super(key: key);

  @override
  State<UploadPostMainWidget> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostMainWidget> {


  File? _image;
  bool _uploading = false;

  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return _image == null ? _uploadPostWidget() : Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        leading: GestureDetector(onTap: () => setState(() => _image = null), child: Icon(Icons.close)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(onTap: _submitPost, child: Icon(Icons.arrow_forward)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: profileWidget(imageUrl: "${widget.currentUser.profileUrl}")),
            ),
            sizeVer(10),
            Text("${widget.currentUser.username}", style: TextStyle(color: Colors.white),),
            sizeVer(10),
            Container(
              height: 200,
              width: double.infinity,
              child: profileWidget(image: _image),
            ),
            sizeVer(10),
            ProfileFormWidget(title: "Description"),
            sizeVer(10),
            _uploading == true? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Uploading",style: TextStyle(color: Colors.white),),
                sizeHor(10),
                CircularProgressIndicator()
              ],
            ) : Container(height: 0,width: 0,),
          ],
        ),
      ),
    );
  }

  _submitPost() {
    setState(() {
      _uploading = true;
    });
    di.sl<UploadImageToCloudStorage>().call(_image!, true, 'posts').then((imageUrl) {
      _createSubmitPost(image: imageUrl);
    });
  }


  _createSubmitPost({required String image}) {
    BlocProvider.of<PostCubit>(context).createPost(post: PostEntity(
        description: _descriptionController.text,
        createAt: Timestamp.now(),
        creatorUid: widget.currentUser.uid,
        postId: Uuid().v1(),
        postImageUrl: image,
        totalComments: 0,
        totalLikes: 0,
        username: widget.currentUser.username
    )).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _uploading = false;
      _descriptionController.clear();
      _image = null;
    });
  }


  _uploadPostWidget() {
    return Scaffold(
      backgroundColor: backGroundColor,

      body: Center(
        child: GestureDetector(
          onTap: selectImage,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: secondaryColor.withOpacity(.3),
                shape: BoxShape.circle),
            child: Center(
              child: Icon(Icons.upload, color: primaryColor, size: 40,),
            ),
          ),
        ),
      ),
    );
  }

}