import 'package:flutter/material.dart';

import 'firebase_on_screen.dart';
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
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: MainScreen(),
          ),
        ),
      ),
    );
  }
}
