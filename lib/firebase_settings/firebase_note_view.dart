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
        title: Text('Edit Note'),
        content: Column(
          children: [
            TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter new $field1',
                hintStyle: TextStyle(color: Colors.black),
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
                hintStyle: TextStyle(color: Colors.black),
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
        if (snapshot.hasData) {
          final clients = snapshot.data?.docs.reversed.toList();
          for (var client in clients!) {
            final clientWidget = Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                      // Delete
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
            );

            clientWidgets.add(clientWidget);
          }
        }
        return ListView(
          children: clientWidgets,
        );
      },
    );
  }
}
