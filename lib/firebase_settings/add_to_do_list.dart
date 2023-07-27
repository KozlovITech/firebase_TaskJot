import 'package:flutter/material.dart';
import 'package:firebasetrain2/Navigator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/custom-app_bar.dart';


class AddToDoList extends StatefulWidget {
  const AddToDoList({Key? key}) : super(key: key);

  @override
  State<AddToDoList> createState() => _AddToDoListState();
}

class _AddToDoListState extends State<AddToDoList> {

  bool value = false;
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
      _index = _prefs.getInt('noteIndex_$userId') ?? userId.hashCode;
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

  Future<void> createField(
      String field1,
      /*String field2, */
      ) async {
    String newValue1 = '';
    //String newValue2 = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add ToDo'),
        content: Column(
          children: [
            TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter new ToDo',
                hintStyle: const TextStyle(color: Colors.black),
              ),
              onChanged: (value) {
                newValue1 = value;
              },
            ),
          ],
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
            onPressed: () => Navigator.pop(context, {
              '$field1': newValue1, /*'$field2': newValue2*/
            }),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    indexId();
    Timestamp currentTime = Timestamp.now();
    // Update Firestore
    if (newValue1.trim().isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('ToDoList')
          .doc('$_index')
          .set({
        field1: newValue1,
        'isChecked': false,
        'timestamp': currentTime,
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
        child: FloatingActionButton(
          foregroundColor: Colors.black,
          backgroundColor: Color.fromRGBO(255, 90, 95, 1),
          onPressed: () {
            setState(() {
              createField('toDoText');
            });
          },
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
    );
  }
}
