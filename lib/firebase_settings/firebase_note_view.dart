import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseNoteView extends StatefulWidget {
  const FirebaseNoteView({Key? key}) : super(key: key);

  @override
  State<FirebaseNoteView> createState() => _FirebaseNoteViewState();
}

class _FirebaseNoteViewState extends State<FirebaseNoteView> {

  Future<void> editField(
      String field1, String field2, String documentId) async {
    String newValue1 = '';
    String newValue2 = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Note'),
        content: Column(
          children: [
            TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter new $field1',
                hintStyle: const TextStyle(color: Colors.black),
              ),
              onChanged: (value) {
                newValue1 = value;
              },
            ),
            TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter new $field2',
                hintStyle: const TextStyle(color: Colors.black),
              ),
              onChanged: (value) {
                newValue2 = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(
                context, {'$field1': newValue1, '$field2': newValue2}),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    // Update Firestore
    if (newValue1.trim().isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Note')
          .doc(documentId)
          .update({field1: newValue1});
    }

    if (newValue2.trim().isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Note')
          .doc(documentId)
          .update({field2: newValue2});
    }
  }

  Color stringToColor(String colorString, double alpha) {
    Color baseColor;
   if (colorString == 'Pale orange') {
      baseColor = const Color.fromRGBO(255, 177, 107, 1.0);
    } else if (colorString == 'Dark turquoise') {
      baseColor = const Color.fromRGBO(128, 203, 196, 1.0);
    } else if (colorString == 'Golden Yellow') {
      baseColor = const Color.fromRGBO(255, 205, 86, 1.0);
    } else {
     baseColor = Colors.black;
    }

   /* final hslColor = HSLColor.fromColor(baseColor);
    final modifiedHslColor = hslColor.withSaturation(saturation);
    return modifiedHslColor.toColor();
*/
    return baseColor.withOpacity(alpha);
  }

  @override
  Widget build(BuildContext context) {

    String userId = FirebaseAuth.instance.currentUser!.uid;
    Query<Map<String, dynamic>> note = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Note')
        .orderBy('timestamp');


    return StreamBuilder<QuerySnapshot>(
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
                Image.asset('assets/img/cat.png',
                  width: 350,
                  height: 350,
                ),
                const SizedBox(height: 25,),
                const Text(
                  "Add New Note",
                  style: TextStyle(fontSize: 28,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      //letterSpacing: 3
                  ),
                ),
              ],
            ),
          );
        }
        else if (snapshot.hasData) {
          final clients = snapshot.data?.docs.reversed.toList();
          for (var client in clients!) {
            final clientWidget = Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(0,10,10,10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: stringToColor(client['color'], 0.7),
              ),
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 10,
                         // height: 40,
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: stringToColor(client['color'], 1),
                          ),
                        ),
                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                client['name'],
                                style: const TextStyle(
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                ),
                                softWrap: true,
                              ),
                              Text(
                                client['text'],
                                style: const TextStyle(
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                editField('name', 'text', client.id);
                              },
                              icon: const Icon(
                                Icons.create,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                var collection = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userId)
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
        }else if (snapshot.hasError) {
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
    );
  }
}