import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
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
    );
  }
}
