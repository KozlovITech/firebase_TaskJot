import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseScreen extends StatelessWidget {
  const FirebaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference cities =
        FirebaseFirestore.instance.collection('client');

    return StreamBuilder<QuerySnapshot>(
      stream: cities.snapshots(),
      builder: (context, snapshot) {
        List<Row> clientWidgets = [];
        if (snapshot.hasData) {
          final clients = snapshot.data?.docs.reversed.toList();
          for (var client in clients!) {
            final clientWidget = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(client['name']),
                Text(client['email']),
                Text(client['mobile']),
                Text(client['photo']),
                IconButton(
                    onPressed: () {
                      var collection =
                          FirebaseFirestore.instance.collection('client');
                      collection.doc(client.id).delete();
                    },
                    icon: const Icon(Icons.delete))
              ],
            );
            clientWidgets.add(clientWidget);
          }
        }
        return Expanded(
          child: ListView(
            children: clientWidgets,
          ),
        );
      },
    );
  }
}
