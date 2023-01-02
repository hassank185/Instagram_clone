import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/cloud_storage_usecase/upload_image_to_cloud_storage_usecase.dart';
import 'package:instagram_clone/features/presentation/manager/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:instagram_clone/theme/style.dart';
import 'package:instagram_clone/injection_container.dart' as di;
class UpdatePostMainWidget extends StatefulWidget {
  final PostEntity post;

  const UpdatePostMainWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<UpdatePostMainWidget> createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostMainWidget> {
  TextEditingController? _descriptionController;

  File? _image;
  bool? _uploading = false;

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
  void initState() {
    _descriptionController = TextEditingController(text: widget.post.description);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text("Edit Post"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: _updatePost,
              child: Icon(
                Icons.done,
                color: blueColor,
                size: 28,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: profileWidget(imageUrl: "${widget.post.userProfileUrl}"),
                ),
              ),
              sizeVer(10),
              Text(
                "${widget.post.username}",
                style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              sizeVer(10),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: profileWidget(
                      imageUrl: widget.post.postImageUrl,
                      image: _image,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: blueColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sizeVer(10),
              ProfileFormWidget(
                controller: _descriptionController,
                title: "Description",
              ),
              sizeVer(10),
              _uploading == true? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Updating the Post",style: TextStyle(color: Colors.white),),
                  sizeHor(10),
                  CircularProgressIndicator()
                ],
              ) : Container(height: 0,width: 0,),
            ],
          ),
        ),
      ),
    );
  }

  _updatePost(){
    setState((){
      _uploading = true;
    });
    if(_image == null){
      _submitUpdatePost(image: widget.post.postImageUrl!);
    } else{
      di.sl<UploadImageToCloudStorage>().call(_image, true, "posts").then((imageUrl) {
        _submitUpdatePost(image: imageUrl);
      });
    }
  }


  _submitUpdatePost({required String image}){
    BlocProvider.of<PostCubit>(context).updatePost(post: PostEntity(
        creatorUid: widget.post.creatorUid,
        postId: widget.post.postId,
        postImageUrl: image,
        description: _descriptionController!.text
    )).then((value) => _clear());
  }

  _clear(){
    setState((){
      _uploading = false;
      _image = null;
      _descriptionController!.clear();
      Navigator.pop(context);
    });
  }
}
