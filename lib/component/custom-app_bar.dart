import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
       /* gradient: LinearGradient(
          colors: [Color(0xff673ab7), Color(0xff9c27b0)],
          stops: [0.1, 1],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),*/
        color: Color.fromRGBO(36, 41, 46,1)
      ),
      height: 100,
      //color: Colors.deepPurple,
      child: const Center(child: Text("TaskJot",style: TextStyle(
          fontFamily: 'Poppins',
          fontSize:32,
          color: Color.fromRGBO(255, 255, 255,1),
          //letterSpacing: 12
      ),
      )),
    );
  }
}
