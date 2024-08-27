// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/main.page.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:todo_app/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD1IgqLytlJ3DRiIVuyHK4WdhnkJI-EUWQ",
            projectId: "todo-app-c6a72",
            messagingSenderId: "823201019036",
            appId: "1:823201019036:web:10bb04d9baf60020562959",
            ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Main_Page(),
      // home: LogIN_Screen(
      //   () {}, // Replace with your function
      //   key: Key('login_screen'), // Add a key for the widget
      // ),
    );
  }
}
