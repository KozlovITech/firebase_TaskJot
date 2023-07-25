import 'package:firebasetrain2/Navigator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/custom-app_bar.dart';

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

  void clearTextField() {
    FocusScope.of(context).unfocus();
    nameController.clear();
    textController.clear();
  }

  Future<void> addNote() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDocument =
        userCollection.doc(userId).collection('Note').doc('$_index');

    Timestamp currentTime = Timestamp.now(); // Отримання поточного часу

    await userDocument.set({
      'name': nameController.text,
      'text': textController.text,
      'timestamp': currentTime, // Додайте поле для часу
      'color': dropdownValue,
    });
    clearTextField();
    indexId();

    setState(() {}); // оновіть стан, щоб відображення змін
  }

  void routeNoteScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MainNavigator()));
  }

  final nameController = TextEditingController();
  final textController = TextEditingController();
  String dropdownValue = 'black';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
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
                    const SizedBox(height: 25),

                  //Choose the color of the note
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder( //<-- SEE HERE
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder( //<-- SEE HERE
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.greenAccent,
                      ),
                      dropdownColor: Colors.greenAccent,
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['black', 'red', 'green', 'purple', 'indigo'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),


                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ElevatedButton(
                        onPressed: addNote,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: const Text(
                          'Add Note',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
          child: FloatingActionButton(
            foregroundColor: Colors.black,
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: const Icon(
              Icons.arrow_back_ios_sharp,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
