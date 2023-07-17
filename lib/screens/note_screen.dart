import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../firebase_settings/firebase_note_view.dart';


class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return  SingleChildScrollView(
      child: Column(
        children: [
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff673ab7), Color(0xff9c27b0)],
                  stops: [0.1, 1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              height: 100,
              //color: Colors.deepPurple,
              child: const Center(child: Text("Note",style: TextStyle(fontSize:32,
                  color: Colors.white,
                  letterSpacing: 12),
              )),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
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
    );
  }
}


