
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/presentation/manager/auth/auth_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/credential_cubit/credential_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/user/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/user/user_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/credential/sign_in_page.dart';
import 'package:instagram_clone/features/presentation/pages/main_screen/main_screen_page.dart';

import 'on_generate_route.dart';
import 'injection_container.dart' as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(context),
        ),
        BlocProvider<CredentialCubit>(
          create: (_) => di.sl<CredentialCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (_) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider<PostCubit>(
            create: (_) => di.sl<PostCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Instagram Clone",
        onGenerateRoute: OnGenerateRoute.route,
        darkTheme: ThemeData.dark(),
        initialRoute: "/",
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  print("uid ${authState.uid}");
                  return MainScreen(
                    uid: authState.uid,
                  );
                } else
                  return LoginPage();
              },
            );
          },
        },
      ),
    );
  }
}
