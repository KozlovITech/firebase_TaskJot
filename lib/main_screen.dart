import 'package:firebasetrain2/firebase_photo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_on_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final mobileController = TextEditingController();
    final photoController = TextEditingController();
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          TextFormField(
            controller: mobileController,
            decoration: const InputDecoration(
              hintText: 'Phone number',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              CollectionReference collRef =
                  FirebaseFirestore.instance.collection('client');
              collRef.add({
                'name': nameController.text,
                'email': emailController.text,
                'mobile': mobileController.text,
              });
            },
            child: const Text("Add Client"),
          ),
          const SizedBox(height: 10),
          //  GetStudentName('sample'),
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
          // Включення віджету GetStudentName()

          TextFormField(
            controller: photoController,
            decoration: const InputDecoration(
              hintText: 'Add link to photo',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              CollectionReference collRef =
                  FirebaseFirestore.instance.collection('photo');
              collRef.add({
                'photo': photoController.text,
              });
            },
            child: const Text("Add Image"),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: screenHeight - 10,
            width: 200,
            child: FirebasePhoto(),
          ),
        ],
      ),
    );
  }
}


