// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/main.page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Main_Page(),
      // home: LogIN_Screen(
      //   () {}, // Replace with your function
      //   key: Key('login_screen'), // Add a key for the widget
      // ),
    );
  }
}
