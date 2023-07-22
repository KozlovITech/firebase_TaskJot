import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../component/custom-app_bar.dart';
import '../firebase_settings/firebase_note_view.dart';


class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return  const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left:10.0, right: 10),
              child: SingleChildScrollView(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}


