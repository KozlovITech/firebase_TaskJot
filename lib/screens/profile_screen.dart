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

    return Column(
      children: [
        const CustomAppBar(),
        Image.asset('assets/img/cat_profile.png',
          width: 200,
          height: 200,
        ),
        const Flexible(
          child: FirebaseProfile(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ElevatedButton(
              onPressed: signOut,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color.fromRGBO(218, 165, 32, 1),
              ),
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}