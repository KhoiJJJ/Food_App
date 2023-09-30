import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign out user
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn(scopes: <String>['email']).signOut();
    return 'Sign Out success';
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _firebaseAuth.signInWithCredential(credential);
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (error) {
      throw error;
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password, String phone, String name) async {
  try {

    final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await addUserInfor(email, phone, name);

    return userCredential;
  } catch (error) {
    throw error; 
  }
}

Future<void> addUserInfor(String email, String phone, String name) async {
  await FirebaseFirestore.instance.collection('users').add({
    'email': email,
    'phone': phone,
    'name': name,
  });
}
}
