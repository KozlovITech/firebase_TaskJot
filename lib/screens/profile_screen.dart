import 'package:flutter/material.dart';


import '../firebase_settings/firebase_on_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final screenHeight = MediaQuery.of(context).size.height;

    return const SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Name:'),
              Text('Email:'),
              Text('Mobile:'),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: FirebaseScreen(),
          ),
          SizedBox(height: 10),
          Text(
            "It's Profile Screen",
            style: TextStyle(
                fontSize: 24,
                color: Colors.purple
            ),
          ),


        ],
      ),
    );
  }
}


