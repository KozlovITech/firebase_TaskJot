import 'package:firebasetrain2/auth/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
        home: Scaffold(
      body: /*Container(
        decoration:  const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff673ab7), Color(0xff9c27b0)],
              stops: [0.1, 1],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),),
       // child:
            child: const*/ Padding(
          padding: EdgeInsets.all(25),
         // child: MainNavigator(),
          child: MainPage(),
        ),
      ),
    );
  }
}
