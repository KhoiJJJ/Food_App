import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/auth/sign_up.dart';
import 'package:food_app/screen/bottom_bar.dart';
import 'package:food_app/widgets/top_titles.dart';

import '../constants/routes.dart';
import '../firebase/firebase_auth_helper.dart';
import '../widgets/primary_button.dart';
import '../widgets/show_alert.dart';
import '../widgets/small_text.dart';

class Welcome extends StatelessWidget {
  const Welcome ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(title: 'Welcome', subtitle: 'Buy any items from this app'),
            Center(child: Image.asset("assets/shop-image.png",)),
            const SizedBox(height: 18,),
            PrimaryButton(title:'Login',onPressed: (){
              Routes.instance.push(widget: const SignInPage(),context: context);
            },),
            const SizedBox(height: 18,),
            PrimaryButton(title:'Sign up',onPressed: (){
              Routes.instance.push(widget: const SignUpPage(),context: context);
            },),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  SmallText(text: 'Or you can login by these methods',color: Colors.grey[800],),
                  const SizedBox(height: 10,),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () {
                      AuthenticationProvider().signInWithGoogle().then((value) {
                        showAlert(context, "You logged in");
                        Routes.instance.pushAndRemoveUntil(widget: const BottomBar(), context: context);
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
            Center(
              child: Column(
                children: [
                  SmallText(
                      text: 'By signing in you are agreeing to our',
                      color: Colors.grey[800]),
                  SmallText(
                    text: 'Term and Privacy Policy',
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
