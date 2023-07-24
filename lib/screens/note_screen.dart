import 'package:firebasetrain2/screens/add_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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
        context, MaterialPageRoute(builder: (context) => const AddNoteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 575,
                      child: FirebaseNoteView(),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.deepPurple,
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
