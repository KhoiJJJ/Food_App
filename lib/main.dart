import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/theme.dart';
import 'package:food_app/provider/app_provider.dart';
import 'package:food_app/screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> AppProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData,
        home:const SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

