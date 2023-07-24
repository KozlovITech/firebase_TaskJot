import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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

  void indexId(){
    setState(() {
      _index++;
    });
  }

  void routeNoteScreen(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> const NoteScreen())

    );
  }


  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Column(
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Hello, ${currentUser.email != null ? currentUser.email! : ''}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                      onPressed: routeNoteScreen,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
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

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
