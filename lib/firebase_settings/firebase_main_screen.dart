import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetrain2/screens/add_note_screen.dart';
import 'package:flutter/material.dart';

class FirebaseMainScreen extends StatefulWidget {
  const FirebaseMainScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseMainScreen> createState() => _FirebaseMainScreenState();
}

class _FirebaseMainScreenState extends State<FirebaseMainScreen> {


  void routeNoteScreen() {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const AddNoteScreen()),
  );
  }

  @override
  Widget build(BuildContext context) {

    Color stringToColor(String colorString, double saturation) {
      Color baseColor;
      /*if (colorString == 'black') {
        baseColor = Colors.black;
      } else if (colorString == 'red') {
        baseColor = const Color.fromRGBO(255, 2, 26, 1.0);
      } else if (colorString == 'green') {
        baseColor = const Color.fromRGBO(56, 222, 0, 1.0);
      } else if (colorString == 'purple') {
        baseColor = const Color.fromRGBO(192, 0, 231, 1.0);
      } else if (colorString == 'indigo') {
        baseColor = const Color.fromRGBO(1, 40, 222, 1.0);
      } else {
        baseColor = Colors.black;
      }*/
      if (colorString == 'black') {
        baseColor = Colors.black;
      } else if (colorString == 'red') {
        baseColor = const Color.fromRGBO(255, 177, 107, 1.0);
      } else if (colorString == 'green') {
        baseColor = const Color.fromRGBO(128, 203, 196, 1.0);
      } else if (colorString == 'purple') {
        baseColor = const Color.fromRGBO(255, 205, 86, 1.0);
      } else if (colorString == 'indigo') {
        baseColor = const Color.fromRGBO(1, 40, 222, 1.0);
      } else {
        baseColor = Colors.black;
      }

      final hslColor = HSLColor.fromColor(baseColor);
      final modifiedHslColor = hslColor.withSaturation(saturation);
      return modifiedHslColor.toColor();

     // return baseColor.withOpacity(alpha);
    }



    String userIdNote = FirebaseAuth.instance.currentUser!.uid;
    Query<Map<String, dynamic>> note = FirebaseFirestore.instance
        .collection('users')
        .doc(userIdNote)
        .collection('Note')
        .orderBy('timestamp', descending: false)
        .limit(4);

    String userIdToDoList = FirebaseAuth.instance.currentUser!.uid;
    Query<Map<String, dynamic>> toDoList = FirebaseFirestore.instance
        .collection('users')
        .doc(userIdToDoList)
        .collection('ToDoList')
        .orderBy('timestamp', descending: true)
        .limit(1);



    return SingleChildScrollView(
      child: Column(
        children: [
         /* const Text(
          "Add New Note",
          style: TextStyle(fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: 3),
        ),*/
         /* Image.asset('assets/img/cat_main.png',
            width: 300,
            height: 300,
          ),*/

          //SizedBox(height: 150,),
          SizedBox(
            child: StreamBuilder<QuerySnapshot>(
              stream: note.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  );

                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  final clients = snapshot.data!.docs.reversed.toList();
                  return Column(
                    children: [
                      Image.asset('assets/img/cat_main.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 15),
                      const Text('Your Last Note',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),),

                      SizedBox(
                        height: 400,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Two columns
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: clients.length,
                          itemBuilder: (context, index) {
                            var client = clients[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 160,
                                        width: 160,
                                        //margin: const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.fromLTRB(0,10,10,10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 4,
                                            color: stringToColor(client['color'], 0.9),
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                                          color: stringToColor(client['color'], 0.45),
                                        ),
                                        child: Column(
                                          children: [
                                            IntrinsicHeight(
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 10,
                                                    height: 129,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                      color: stringToColor(client['color'], 0.9),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          client['name'],
                                                          style: const TextStyle(
                                                            color: Color.fromRGBO(51, 51, 51, 1),
                                                            fontFamily: 'Roboto',
                                                            fontSize: 23,
                                                          ),
                                                          softWrap: false,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Text(
                                                          client['text'],
                                                          style: const TextStyle(
                                                            color: Color.fromRGBO(51, 51, 51, 1),
                                                            fontFamily: 'Roboto',
                                                            fontSize: 18,
                                                          ),
                                                          softWrap: false,
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {

                  return SizedBox(

                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: [
                          const Text(
                            "Click on the cat to add a Note before it's too late..",
                            style: TextStyle(fontSize: 28,
                                fontFamily: 'Poppins',
                                letterSpacing: 3),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: TextButton(
                              onPressed: routeNoteScreen,
                              child: Image.asset(
                                'assets/img/cat_notData.png',
                                width: 400,
                                height: 400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
