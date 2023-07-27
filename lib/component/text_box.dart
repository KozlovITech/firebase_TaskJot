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
      decoration:  BoxDecoration(
        //  color: const Color.fromRGBO(255, 224, 178,1),
          //color: const Color.fromRGBO(125, 35, 35,1),
          color: const Color.fromRGBO(0, 0, 0,1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 4,
         // color: const Color.fromRGBO(255, 177, 107,1)
          //color: const Color.fromRGBO(153, 51, 51,1)
            //color: const Color.fromRGBO(255, 223,0,1)
            color: const Color.fromRGBO(218, 165, 32, 1.0)
        )
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
                            color: Color.fromRGBO(218, 165, 32, 1),
                            fontFamily: 'Roboto',
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: const TextStyle(
                    color: Color.fromRGBO(218, 165, 32, 1),
                    fontFamily: 'Roboto',
                    fontSize: 20),
              ),
            ],
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.settings,
              color: Color.fromRGBO(218, 165, 32, 1),
            ),
          ),
        ],
      ),
    );
  }
}
