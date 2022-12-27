import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/manager/auth/auth_cubit.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:instagram_clone/theme/style.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity currentUser;

  const ProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text('${currentUser.username}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {
                  _openModelSheet(context);
                },
                child: Icon(
                  Icons.menu,
                  color: primaryColor,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(40),
                     child: profileWidget(imageUrl: currentUser.profileUrl)
                   )
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "${currentUser.totalPosts}",
                            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                          ),
                          sizeVer(8),
                          Text(
                            "Posts",
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          Text(
                            "${currentUser.totalFollowers}",
                            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                          ),
                          sizeVer(8),
                          Text(
                            "Followers",
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          Text(
                            "${currentUser.totalFollowing}",
                            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                          ),
                          sizeVer(8),
                          Text(
                            "Following",
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              sizeVer(10),
              Text(
                "${currentUser.name == "" ? currentUser.username : currentUser.name}",
                style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              ),
              Text(
                "${currentUser.bio}",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
              sizeVer(8),
              GridView.builder(
                  itemCount: 32,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: secondaryColor,
                    );
                  })
            ],
          ),
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
                        onTap: () {
                          Navigator.pushNamed(context, PageConst.editProfilePage,arguments: currentUser);
                        },
                        child: Text(
                          "Edit Profile",
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
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<AuthCubit>(context).loggedOut();
                        Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false);
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
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
