import 'package:flutter/material.dart';

import '../firebase_settings/firebase_note_view.dart';


class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return const SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 10),
            SizedBox(
              height: 500,
              child: FirebaseNoteView(),
            ),
            SizedBox(height: 10),
          ],
        ),
    );
  }
}


