import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/presentation/manager/auth/auth_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/credential_cubit/credential_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/credential/sign_up_page.dart';
import 'package:instagram_clone/features/presentation/pages/main_screen/main_screen_page.dart';
import 'package:instagram_clone/features/presentation/widgets/form_container_widget.dart';

import '../../../../consts.dart';
import '../../../../theme/style.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  static const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  String? password;
  //bool _isSigningIn = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            print(credentialState );
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            toast("Invalid Email & Password ");
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(
                    uid: authState.uid,
                  );
                } else {
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
      ),
    );
  }

  _bodyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(),
          flex: 2,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 40,
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormContainerWidget(
                        hintText: 'Enter your email',
                        inputType: TextInputType.emailAddress,
                        controller: _emailController,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "field cannot be empty";
                        //   } else if (RegExp(emailRegex).hasMatch(value)) {
                        //   } else {
                        //     return "email not correctly formatted";
                        //   }
                        // }
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FormContainerWidget(
                        hintText: 'Enter your password',
                        inputType: TextInputType.text,
                        controller: _passwordController,
                        isPasswordField: true,
                        onFieldSubmitted: (value) {
                          password = value;
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "field cannot be empty";
                        //   } else if (value.length < 6) {
                        //     return "must be at least 6 characters";
                        //   } else if (value.length > 20) {
                        //     return "password too long max characters are 20";
                        //   } else {
                        //     return null;
                        //   }
                        // }
                      )],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: _submitLogin,
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text("Sign In", style: TextStyle(color: primaryColor),),
                  ),
                ),
              ),
              sizeVer(10),
              // _isSigningIn == true? Row(
              //   children: [
              //     Text("Please wait...", style: TextStyle(color: primaryColor),),
              //     sizeHor(10),
              //     CircularProgressIndicator(backgroundColor: primaryColor,),
              //   ],
              // ): Container()
            ],
          ),
        ),
        Flexible(
          child: Container(),
          flex: 2,
        ),
        Container(
          child: Column(
            children: [
              Divider(
                color: secondaryColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: TextStyle(color: primaryColor),),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUpPage()), (route) => false);
                    },
                    child:  Text(
                      "Sign Up.",
                      style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        )
      ],
    );
  }

  void _submitLogin() {
    if(_emailController.text.isEmpty){
    toast("enter email adress");
    return ;}
    if(_passwordController.text.isEmpty){
    toast("enter password");
    return ;}
    BlocProvider.of<CredentialCubit>(context).signInUser(email: _emailController.text, password: _passwordController.text);
  }
}
