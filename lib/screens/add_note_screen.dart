import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  int _index = 0;

  void indexId() {
    setState(() {
      _index++;
    });
  }

  Future<void> addNote() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDocument =
        userCollection.doc(userId).collection('Note').doc('$_index');

    await userDocument.set({
      'name': nameController.text,
      'text': textController.text,
    });

    indexId();
  }

  final nameController = TextEditingController();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          ElevatedButton(
            onPressed: () {
              addNote();
              indexId();
            },
            child: const Text("Add Note"),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
