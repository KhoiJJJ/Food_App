import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food_app/auth/sign_up.dart';
import 'package:food_app/screen/bottom_bar.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:food_app/widgets/top_titles.dart';

import '../constants/routes.dart';
import '../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../widgets/primary_button.dart';
import '../widgets/show_alert.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isShowPassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  title: 'Login', subtitle: 'Welcome back to iCart'),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.password_sharp),
                    suffixIcon: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        padding: EdgeInsets.zero,
                        child: Icon(
                          isShowPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ))),
              ),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                title: 'Login',
                onPressed: () {
                  AuthenticationProvider()
                      .signInWithEmailAndPassword(
                          _emailController.text, _passwordController.text)
                      .then((userCredential) {
                    showAlert(context, "You logged in");
                    Routes.instance.pushAndRemoveUntil(
                        widget: const BottomBar(), context: context);
                  }).catchError((e) {
                    showAlert(context, e.toString());
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Center(child: SmallText(text: "Don't have an account?")),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: GestureDetector(
                onTap: () {
                  Routes.instance
                      .push(widget: const SignUpPage(), context: context);
                },
                child: SmallText(
                  text: 'Create an account',
                  size: 17,
                  color: Colors.blue,
                ),
              )),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SmallText(
                      text: 'Or you can login by these methods',
                      color: Colors.grey[800],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignInButton(
                      Buttons.Google,
                      text: "Sign up with Google",
                      onPressed: () {
                        AuthenticationProvider()
                            .signInWithGoogle()
                            .then((value) {
                          showAlert(context, "You logged in");
                          Routes.instance.pushAndRemoveUntil(
                              widget: const BottomBar(), context: context);
                        }).catchError((e) {
                          showAlert(context, e.toString());
                        });
                      },
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      text: "Sign up with Facebook",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
