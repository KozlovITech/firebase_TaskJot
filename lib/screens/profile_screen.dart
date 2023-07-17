import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../firebase_settings/firebase_on_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final screenHeight = MediaQuery.of(context).size.height;

    return  SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Name:'),
              Text('Email:'),
              Text('Mobile:'),
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(
            height: 100,
            child: FirebaseScreen(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text("Sign Out"),
          ),


        ],
      ),
    );
  }
}


