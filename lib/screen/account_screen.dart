import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/widgets/small_text.dart';

import '../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../widgets/custom_app_bar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(
          word1: "E-Commerce",
          word2: "iCart",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 130,
                ),
                SmallText(
                  text: 'User',
                  size: 22,
                ),
                const Text(
                  "ngockhoi4423@gmail.com",
                  style: TextStyle(fontSize: 15),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child:  SmallText(text:"hello",size: 18,),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.shopping_bag_outlined),
                    onTap: () {},
                    title: const Text("Yours Order"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite_outline),
                    onTap: () {},
                    title: const Text("Favorite"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    onTap: () {},
                    title: const Text("About Us"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.replay_circle_filled_outlined),
                    onTap: () {},
                    title: const Text("Return & Refund"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.headset_mic_outlined),
                    onTap: () {},
                    title: const Text("Support"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    onTap: () {
                      AuthenticationProvider().signOut().then((value) {
                        Navigator.of(context,rootNavigator: true).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()),
                            (_) => false);
                      });
                     
                    },
                    title: const Text("Log out"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text("Version 1.0.0")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
