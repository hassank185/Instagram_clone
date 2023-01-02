import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/presentation/manager/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/home/widgets/single_post_widget.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/comment_page.dart';
import 'package:instagram_clone/theme/style.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class HomePage extends StatelessWidget {

  const HomePage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: SvgPicture.asset("assets/ic_instagram.svg", color: primaryColor, height: 30,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(MaterialCommunityIcons.facebook_messenger, color: primaryColor,),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) =>
        di.sl<PostCubit>()
          ..getPosts(post: PostEntity()),
        child: BlocBuilder<PostCubit, PostState>(
            builder: (context, postState) {
              if (postState is PostLoading) {
                return Center(child: CircularProgressIndicator(),);
              }
              if (postState is PostFailure) {
                toast("Some Failure occur while creating post");
              }

              if (postState is PostLoaded) {
                return postState.posts.isEmpty? _noPostYetWidget() :ListView.builder(itemCount: postState.posts.length, itemBuilder: (context, index) {
                  final post = postState.posts[index];
                  return BlocProvider(
                    create: (context) => di.sl<PostCubit>(),
                    child: SinglePostCardWidget(post: post),
                  );
                });
              }
              return Center(child: CircularProgressIndicator(),);
            }
        ),
      ),
    );
  }

  _noPostYetWidget(){
    return Center(child: Text("No Posts Yet",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),);
  }

}
