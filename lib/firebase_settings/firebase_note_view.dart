import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseNoteView extends StatelessWidget {
  const FirebaseNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference note = FirebaseFirestore.instance.collection('Note');

    return StreamBuilder<QuerySnapshot>(
      stream: note.snapshots(),
      builder: (context, snapshot) {
        List<Container> clientWidgets = [];
        if (snapshot.hasData) {
          final clients = snapshot.data?.docs.reversed.toList();
          for (var client in clients!) {
            final clientWidget = Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.deepOrange,
              ),
              child:
              Row(
                children: [
                  Column(
                    children: [
                      Text(client['name']),
                      Text(client['text']),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      var collection =
                      FirebaseFirestore.instance.collection('Note');
                      collection.doc(client.id).delete();
                    },
                    icon: const Icon(Icons.delete),
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
