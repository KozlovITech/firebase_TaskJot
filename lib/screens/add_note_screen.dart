import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final textController = TextEditingController();

    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Name Note',
            ),
          ),
          TextFormField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Text Note',
            ),
          ),
       /*   TextFormField(
            controller: mobileController,
            decoration: const InputDecoration(
              hintText: 'Phone number',
            ),
          ),*/
          ElevatedButton(
            onPressed: () {
              CollectionReference collRef =
              FirebaseFirestore.instance.collection('Note');
              collRef.add({
                'name': nameController.text,
                'text': textController.text,
              });
            },
            child: const Text("Add Note"),
          ),
          const SizedBox(height: 10),
          const Text(
            "It's Add Note Screen",
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


