import 'package:flutter/material.dart';
import 'package:firebasetrain2/Navigator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/custom-app_bar.dart';

class FirebaseToDoList extends StatefulWidget {
  const FirebaseToDoList({Key? key}) : super(key: key);

  @override
  State<FirebaseToDoList> createState() => _FirebaseToDoListState();
}

class _FirebaseToDoListState extends State<FirebaseToDoList> {
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Query<Map<String, dynamic>> note = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('ToDoList')
        .orderBy('timestamp');

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          const Text(
            'ToDo List',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32, color: Color.fromRGBO(36, 41, 46, 1),
                fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(
            height: 700,
            child: StreamBuilder<QuerySnapshot>(
              stream: note.snapshots(),
              builder: (context, snapshot) {
                List<Widget> clientWidgets = [];

                if (snapshot.data?.size == 0) {
                  // got data from snapshot but it is empty

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 45,),
                        Image.asset('assets/img/cat_toDo.png',
                          width: 350,
                          height: 350,
                        ),

                        const SizedBox(height: 25,),
                        const Text(
                          "Waiting for ToDo",
                          style: TextStyle(fontSize: 28,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            //letterSpacing: 3
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  final clients = snapshot.data?.docs.reversed.toList();
                  for (var client in clients!) {
                    final clientWidget = Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color.fromRGBO(255, 177, 107, 0.7),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        client['toDoText'],
                                        style: const TextStyle(
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: 24,
                                        ),
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    var collection = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userId)
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
