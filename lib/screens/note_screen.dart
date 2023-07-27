import 'package:firebasetrain2/screens/add_note_screen.dart';
import 'package:flutter/material.dart';

import '../component/custom-app_bar.dart';
import '../firebase_settings/firebase_note_view.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  void routeNoteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNoteScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(),
            SizedBox(height: 15,),
            Text(
              'Note',
              style: TextStyle(
                  fontSize: 32, color: Color.fromRGBO(36, 41, 46, 1),
                  fontFamily: 'Poppins',
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                children: [
                  SizedBox(
                   height: 630,
                    child: FirebaseNoteView(),
                  ),

                ],
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
            backgroundColor:  Color.fromRGBO(51, 102, 153, 1),
            onPressed: () {
              setState(() {
                routeNoteScreen();
              });
            },
            child: const Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
