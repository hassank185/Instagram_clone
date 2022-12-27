


import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/comment_page.dart';
import 'package:instagram_clone/theme/style.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: SvgPicture.asset("assets/ic_instagram.svg",color: primaryColor,height: 30,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(MaterialCommunityIcons.facebook_messenger,color: primaryColor,),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    sizeHor(10),
                    Text("username",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),)
                  ],
                ),
                GestureDetector(onTap: (){
                  _openModelSheet(context);
                },child: Icon(Icons.more_vert,color: primaryColor,))
              ],
            ),
            sizeVer(10),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              color: secondaryColor,
            ),
            sizeVer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite,color: primaryColor,
                    ),
                    sizeHor(10),GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommentPage())),
                      child: Icon(
                        Feather.message_circle,color: primaryColor,
                      ),
                    ),
                    sizeHor(10),Icon(
                      Feather.send,color: primaryColor,
                    ),
                    sizeVer(10),
                  ],
                ),
                Icon(Icons.bookmark_outline)
              ],
            ),
            sizeVer(10),
            Text("34 likes",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
            sizeVer(10),
            Row(

              children: [
                Text("username",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                sizeHor(10),
                Text("Some Description",style: TextStyle(color: primaryColor),),
              ],
            ),
            sizeVer(10),
            Text("View all 10 comments",style: TextStyle(color: primaryColor),),
            sizeVer(10),
            Text("08/12/2002",style: TextStyle(color: primaryColor),),
          ],
        ),
      ),
    );
  }
  _openModelSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
              color: backGroundColor.withOpacity(.8),
            ),
            child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "More Options",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
                        ),
                      ),
                      sizeVer(8),
                      Divider(
                        thickness: 1,
                        color: secondaryColor,
                      ),
                      sizeVer(8),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, PageConst.updatePostPage);
                            },
                            child: Text(
                              "Update Post",
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                              ),
                            )),
                      ),
                      sizeVer(7),
                      Divider(
                        thickness: 1,
                        color: secondaryColor,
                      ),
                      sizeVer(8),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Delete Post",
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      sizeVer(7),
                    ],
                  ),
                )),
          );
        });
  }

}
