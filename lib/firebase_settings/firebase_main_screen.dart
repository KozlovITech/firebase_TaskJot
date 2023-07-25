import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseMainScreen extends StatefulWidget {
  const FirebaseMainScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseMainScreen> createState() => _FirebaseMainScreenState();
}

class _FirebaseMainScreenState extends State<FirebaseMainScreen> {



  @override
  Widget build(BuildContext context) {

    Color stringToColor(String colorString, double saturation) {
      Color baseColor;
      if (colorString == 'black') {
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
      }

      final hslColor = HSLColor.fromColor(baseColor);
      final modifiedHslColor = hslColor.withSaturation(saturation);
      return modifiedHslColor.toColor();
    }



    String userIdNote = FirebaseAuth.instance.currentUser!.uid;
    Query<Map<String, dynamic>> note = FirebaseFirestore.instance
        .collection('users')
        .doc(userIdNote)
        .collection('Note')
        .orderBy('timestamp', descending: true)
        .limit(1);

    String userIdToDoList = FirebaseAuth.instance.currentUser!.uid;
    Query<Map<String, dynamic>> to_do_list = FirebaseFirestore.instance
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
          Image.asset('assets/img/cat_main.png',
            width: 300,
            height: 300,
          ),

          //SizedBox(height: 150,),
          //The latest Note
          const Align(
            alignment: Alignment.center,
            child: Text(
              'The latest Note',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                letterSpacing: 2
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: StreamBuilder<QuerySnapshot>(
              stream: note.snapshots(),
              builder: (context, snapshot) {
                List<Widget> clientWidgets = [];
                if (snapshot.hasData) {
                  final clients = snapshot.data?.docs.reversed.toList();
                  for (var client in clients!) {
                    final clientWidget = Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: stringToColor(client['color'],0.7),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            Container(
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                color: stringToColor(client['color'],1),
                              ),
                            ),

                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    client['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                    softWrap: true,
                                  ),
                                  Text(
                                    client['text'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                            // Update
                            // Delete
                            IconButton(
                              onPressed: () {
                                var collection = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userIdNote)
                                    .collection('Note');
                                collection.doc(client.id).delete();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                    clientWidgets.add(clientWidget);
                  }
                  return ListView(
                    children: clientWidgets,
                  );
                } else if (snapshot.data?.size == 0) {
                  // got data from snapshot but it is empty

                  return const Text(
                    "no data",
                    style: TextStyle(fontSize: 24),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error ${snapshot.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                );
              }
            ),
          ),
          const SizedBox(height: 15),
          //The latest Note
          const Align(
            alignment: Alignment.center,
            child: Text(
              'The latest ToDo',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2
              ),
            ),
          ),
          //The latest ToDo List
          SizedBox(
            height: 100,
            child: StreamBuilder<QuerySnapshot>(
              stream: to_do_list.snapshots(),
              builder: (context, snapshot) {
                List<Widget> clientWidgets = [];
                if (snapshot.hasData) {
                  final clients = snapshot.data?.docs.reversed.toList();
                  for (var client in clients!) {
                    final clientWidget = Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              setState(() {
                                client.reference.update({
                                  'isChecked': !client['isChecked'],
                                });
                              });
                            },
                            leading: Checkbox(
                              value: client['isChecked'] ?? false,
                              onChanged: (value) {
                                setState(() {
                                  client.reference.update({
                                    'isChecked': value,
                                  });
                                });
                              },
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        client['toDoText'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    var collection = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userIdToDoList)
                                        .collection('ToDoList');
                                    collection.doc(client.id).delete();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                    clientWidgets.add(clientWidget);
                  }
                  return ListView(
                    children: clientWidgets,
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error ${snapshot.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
