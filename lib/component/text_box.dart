import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  void Function()? onPressed;

  MyTextBox(
      {Key? key,
      required this.text,
      required this.sectionName,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(left: 15, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Flexible(
                  child: Column(
                    children: [
                      Text(
                        sectionName,
                        style: const TextStyle(
                            color: Color.fromRGBO(144, 10, 206, 1.0), fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: const TextStyle(
                    color: Color.fromRGBO(14, 236, 223, 1), fontSize: 20),
              ),
            ],
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.settings,
              color: Color.fromRGBO(144, 10, 206, 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
