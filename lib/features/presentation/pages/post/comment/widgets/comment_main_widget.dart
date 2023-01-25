

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/app_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/manager/comment/comment_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/widgets/single_comment_widget.dart';
import 'package:instagram_clone/theme/style.dart';
import 'package:uuid/uuid.dart';


class CommentMainPage extends StatefulWidget {
  final AppEntity appEntity;

  const CommentMainPage({Key? key, required this.appEntity}) : super(key: key);

  @override
  State<CommentMainPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentMainPage> {
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.appEntity.uid!);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text("Comments"),
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, singleUserState) {
          if(singleUserState is GetSingleUserLoaded){
            final singleUser = singleUserState.user;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                          sizeHor(10),
                          Text("Username", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor),),

                        ],
                      ),
                      sizeVer(10),
                      Text("This is very beautiful place", style: TextStyle(color: primaryColor),),
                    ],
                  ),
                ),
                sizeVer(10),
                Divider(
                  color: secondaryColor,
                ),
                sizeVer(10),
                Expanded(
                  child: ListView.builder(itemCount: 10, itemBuilder: (context, index) {
                    return SingleCommentWidget();
                  }),
                ),
                _commentSection(currentUser: singleUser)
              ],
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  _commentSection({required UserEntity currentUser}) {
    return Container(
      width: double.infinity,
      height: 55,
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            sizeHor(10),
            Expanded(
                child: TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Post your comment...",
                      hintStyle: TextStyle(color: secondaryColor)
                  ),
                )),
            GestureDetector(onTap: () {
              _createComment(currentUser);
            }, child: Text("Post", style: TextStyle(fontSize: 15, color: blueColor),))
          ],
        ),
      ),
    );
  }

  _createComment(UserEntity currentUser) {
    BlocProvider.of<CommentCubit>(context).createPost(comment: CommentEntity(
      totalReplays: 0,
      commentId: Uuid().v1(),
      createAt: Timestamp.now(),
      likes: [],
      username: currentUser.username,
      userProfileUrl: currentUser.profileUrl,
      description: _descriptionController.text,
      creatorUid: currentUser.uid,
      postId: widget.appEntity.postId,

    ));
  }
}
