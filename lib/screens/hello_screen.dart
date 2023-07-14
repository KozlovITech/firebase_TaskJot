import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final mobileController = TextEditingController();

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
          const Text(
            "It's Hello Screen",
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
