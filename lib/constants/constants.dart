
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/widgets/small_text.dart';

void showMessage(String message){
  Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
}

showLoaderDialog(BuildContext context){
  AlertDialog alert= AlertDialog(
    content: Builder(builder: (context){
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xffe16555),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 7),
              child: SmallText(text: 'Loading...'),
            )
          ],
        ),
      );
    },),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    });
  
}

String getMessageFromErrorCode(String errorCode){
  switch (errorCode){
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already used. Go to login page";
    case "account-exists-with-defferent-credential":
      return "Email already used. Go to login page";
    case "email-already-in-use":
      return "Email already used. Go to login page";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong Password";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email";
    case "user-not-found":
      return "No user found with this email";
    case "ERROR_INVALID_EMAIL":
      return "Email address is invalid";
    case "invalid-email":
      return "Email address is invalid";
    default: 
      return "Login failed. Please try again!";
  }
}

bool loginValidation(String email,password){
  if(email.isEmpty && password.isEmpty){
    showMessage("Both fields are empty");
    return false;
  }else if(email.isEmpty ){
    showMessage("Email is empty");
    return false;
  }else if(password.isEmpty){
    showMessage('Password is empty');
    return false;
  }else{
    return true;
  }
}