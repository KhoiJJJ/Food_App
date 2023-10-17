import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/constants.dart';
import 'package:food_app/firebase/firebase_auth_helper.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/primary_button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isShowPassword = true;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ), // You can use a different back arrow icon
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(
          word1: "E-Commerce",
          word2: "iCart",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                  hintText: 'New Password',
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
              height: 15,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                  hintText: 'Confirm Password',
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
              title: "Update",
              onPressed: () async {
                if (_passwordController.text.isEmpty) {
                  showMessage(
                      "Password can not be blank. Please enter your password.");
                } else if (_confirmPasswordController.text.isEmpty) {
                  showMessage(
                      "Confirm password can not be blank. Please enter your password.");
                } else if (_confirmPasswordController.text ==
                    _passwordController.text) {
                  AuthenticationProvider()
                      .changePassword(_passwordController.text, context);
                } else {
                  showMessage("Confirm Password is not match");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
