import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../firebase_settings/firebase_on_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    //final screenHeight = MediaQuery.of(context).size.height;

    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
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


            SizedBox(height: 25,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap:  signOut,
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

          ],
        ),
      ),
    );
  }
}


