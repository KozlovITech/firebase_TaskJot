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
                  IconButton(
                    onPressed: () {
                      var collection =
                          FirebaseFirestore.instance.collection('Note');
                      collection.doc(client.id).delete();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
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
