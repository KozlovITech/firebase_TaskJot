import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/custom-app_bar.dart';
import '../firebase_settings/firebase_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;

  //all users
  final userCollection = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          /*gradient: LinearGradient(
            colors: [Color(0xff9c27b0), Color(0xffff9800)],
            stops: [0.5, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )*/
         /* gradient: LinearGradient(
            colors: [Color(0xffe91e63), Color(0xff3f51b5)],
            stops: [0.5, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )*/
          /* LinearGradient(
            colors: [Color(0xff9c27b0), Color(0xff009688)],
            stops: [0.5, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )*/
         /* gradient:LinearGradient(
            colors: [Color(0xffff5722), Color(0xff9c27b0)],
            stops: [0.5, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )*/

         /* gradient: LinearGradient(
            colors: [Color(0xff00bcd4), Color(0xffe91e63)],
            stops: [0.5, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )*/
          gradient: LinearGradient(
            colors: [Color(0xff3f51b5), Color(0xffe91e63)],
            stops: [0.5, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )





      ),
      child: Column(
        children: [
          const CustomAppBar(),
          const Expanded(
            child: FirebaseProfile(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: signOut,
                child: Container(
                  width: 200,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
