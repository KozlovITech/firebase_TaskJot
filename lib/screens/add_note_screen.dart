import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late int _index;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    loadIndex();
  }

  Future<void> loadIndex() async {
    _prefs = await SharedPreferences.getInstance();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    setState(() {
      _index = _prefs.getInt('noteIndex_$userId') ?? 0;
    });
  }

  Future<void> saveIndex() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await _prefs.setInt('noteIndex_$userId', _index);
  }

  void indexId() {
    setState(() {
      _index++;
    });
    saveIndex();
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: addNote,
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
                        'Add Note',
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
      ),
    );
  }
}
