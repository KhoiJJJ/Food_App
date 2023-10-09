import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_app_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void takePhoto() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

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
      body: ListView(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(Icons.camera_alt),
          )
        ],
      ),
    );
  }
}
