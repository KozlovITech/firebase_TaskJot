import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelloScreen extends StatefulWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  int _index = 0;

  void indexId(){
    setState(() {
      _index++;
    });
  }

  final user = FirebaseAuth.instance.currentUser!;
  
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
              collRef.doc('$_index').set({
                'name': nameController.text,
                'email': emailController.text,
                'mobile': mobileController.text,
              });
              indexId();
            },
            child: const Text("Add Client"),
          ),
          const SizedBox(height: 10),


          Text("Signed as: ${user.email!}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),),
        ],
      ),
    );
  }
}
