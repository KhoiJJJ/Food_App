import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/provider/app_provider.dart';
import 'package:food_app/widgets/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_app_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  void takePhoto() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePhoto();
                  },
                  child: const CircleAvatar(
                      radius: 70, child: Icon(Icons.camera_alt)),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePhoto();
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 70,
                  ),
                ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: appProvider.getUserInformation.name,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(
            title: "Update",
            onPressed: () async {
              UserModel userModel = appProvider.getUserInformation
                  .copyWith(name: textEditingController.text);
              appProvider.updateUserInfoFirebase(userModel, image, context);
            },
          )
        ],
      ),
    );
  }
}
