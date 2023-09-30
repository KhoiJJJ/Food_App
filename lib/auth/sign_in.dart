import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:food_app/widgets/top_titles.dart';

import '../constants/routes.dart';
import '../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../screen/home_screen.dart';
import '../widgets/primary_button.dart';
import '../widgets/show_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowPassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(title: 'Login', subtitle: 'Welcome back to iCart'),
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
                AuthenticationProvider().signInWithEmailAndPassword(_emailController.text,_passwordController.text).then((userCredential) {
                      showAlert(context, "You logged in");
                      Routes.instance.pushAndRemoveUntil(widget: const HomeScreen(), context: context);
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
                child: SmallText(
              text: 'Create an account',
              size: 17,
              color: Colors.blue,
            ))
          ],
        ),
      ),
    );
  }
}
