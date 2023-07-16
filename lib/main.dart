import 'package:firebasetrain2/login_page.dart';
import 'package:firebasetrain2/main_page.dart';
import 'package:flutter/material.dart';

import 'Navigator.dart';
import 'firebase_settings/firebase_on_screen.dart';
import 'firebase_read.dart';
import 'main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('FIREBASE'),
      ),
      body: /*Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        )),*/
       // child:
            const Padding(
          padding: EdgeInsets.all(25),
         // child: MainNavigator(),
          child: MainPage(),
        ),
      ),
    );
  }
}
