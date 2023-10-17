import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/screen/account/change_password_screen.dart';
import 'package:food_app/screen/account/edit_profile.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../firebase/firebase_auth_helper.dart';
import '../../provider/app_provider.dart';
import '../../widgets/custom_app_bar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
                appProvider.getUserInformation.image == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 130,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(appProvider.getUserInformation.image!),
                        radius: 70,
                      ),
                Text(
                  appProvider.getUserInformation.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  appProvider.getUserInformation.email,
                  style: const TextStyle(fontSize: 15),
                ),
                ElevatedButton(
                  onPressed: () {
                    Routes.instance
                        .push(widget: const EditProfile(), context: context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: SmallText(
                    text: "Edit Profile",
                    size: 18,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
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
                  leading: const Icon(Icons.change_circle_outlined),
                  onTap: () {
                    Routes.instance.push(
                        widget: const ChangePasswordPage(), context: context);
                  },
                  title: const Text("Change password"),
                ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  onTap: () {
                    AuthenticationProvider().signOut().then((value) {
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
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
          )
        ],
      ),
    );
  }
}
