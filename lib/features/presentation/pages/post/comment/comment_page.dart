import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/user/app_entity.dart';
import 'package:instagram_clone/features/presentation/manager/comment/comment_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/widgets/comment_main_widget.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class CommentPage extends StatelessWidget {
  final AppEntity appEntity;

  const CommentPage({Key? key, required this.appEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<CommentCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
      ],
      child: CommentMainPage(appEntity: appEntity),
    );
  }
}
