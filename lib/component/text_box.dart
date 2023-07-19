import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  void Function()? onPressed;

 MyTextBox({Key? key, required this.text, required this.sectionName,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15,
      bottom: 15,),
      margin: const EdgeInsets.only(left: 15, right: 20, top: 20),
      child: Column(
        children: [
          Text(sectionName),

          IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.settings),
          ),


          Text(text),
        ],
      ),
    );
  }
}
