import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/text_box.dart';

class FirebaseProfile extends StatefulWidget {
  const FirebaseProfile({Key? key}) : super(key: key);

  @override
  State<FirebaseProfile> createState() => _FirebaseProfileState();
}

class _FirebaseProfileState extends State<FirebaseProfile> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all users
  final userCollection = FirebaseFirestore.instance.collection('Users');

  //edit
  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ' + field),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Enter new $field',
            hintStyle: const TextStyle(color: Colors.black),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    //update Firestore
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              //display data
              final username = userData['username'] ?? 'No username';
              final bio = userData['bio'] ?? 'No bio';
              final phoneNumber = userData['mobile phone'] ?? 'No phone number';
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child:  Text(
                      'Welcome Back, ${currentUser.email != null ? currentUser.email! : ''}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        MyTextBox(
                          text: userData['username'],
                          sectionName: 'Username: ',
                          onPressed: () => editField('username'),
                        ),
                        MyTextBox(
                          text: userData['bio'],
                          sectionName: 'Name: ',
                          onPressed: () => editField('bio'),
                        ),
                        MyTextBox(
                          text: userData['mobile phone'],
                          sectionName: 'Phone Number:',
                          onPressed: () => editField('mobile phone'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  //bio
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error ${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator( color: Colors.deepPurple,),
            );
          }),
    );
  }
}