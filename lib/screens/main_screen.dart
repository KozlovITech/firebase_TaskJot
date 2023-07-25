import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetrain2/component/custom-app_bar.dart';
import 'package:firebasetrain2/firebase_settings/firebase_main_screen.dart';
import 'package:flutter/material.dart';

import '../Navigator.dart';
import 'add_note_screen.dart';
import 'note_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final currentUser = FirebaseAuth.instance.currentUser!;

  void indexId() {
    setState(() {
      _index++;
    });
  }

  void routeNoteScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NoteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0,0,20,20),
              child: Column(
                children: [
                  Center(
                    child: FirebaseMainScreen(), // Wrap with Center widget
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
                onPressed: routeNoteScreen,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text(
                  'Go to the NOTE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
