import 'package:firebasetrain2/Navigator.dart';
import 'package:firebasetrain2/firebase_settings/add_to_do_list.dart';
import 'package:firebasetrain2/screens/add_note_screen.dart';
import 'package:flutter/material.dart';

import '../component/custom-app_bar.dart';
import '../firebase_settings/firebase_note_view.dart';
import '../firebase_settings/firebase_to_do_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  void routeNoteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 690,
                    child: FirebaseToDoList(),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),

          ],
        ),

      ),
      floatingActionButton: AddToDoList(),
    );
  }
}
