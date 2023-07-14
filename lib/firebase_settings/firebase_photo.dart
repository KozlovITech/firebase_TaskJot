import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebasePhoto extends StatelessWidget {
  const FirebasePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference cities = FirebaseFirestore.instance.collection('photo');

    return StreamBuilder<QuerySnapshot>(
      stream: cities.snapshots(),
      builder: (context, snapshot) {
        List<Column> clientWidgets = [];
        if (snapshot.hasData) {
          final clients = snapshot.data?.docs.reversed.toList();
          for (var client in clients!) {
            final clientWidget = Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text(client['photo']),
                const SizedBox(height: 15,),
                Image.network(
                  client['photo'],
                  height: 150,
                  fit: BoxFit.fill,
                ),
                IconButton(
                  onPressed: () {
                    var collection =
                    FirebaseFirestore.instance.collection('photo');
                    collection.doc(client.id).delete();
                  },
                  icon: const Icon(Icons.delete),
                )
                /*IconButton(
                  onPressed: () {
                    var collection =
                        FirebaseFirestore.instance.collection('client');
                    collection.doc(client.id).delete();
                  },
                  icon: const Icon(Icons.delete),
                )*/
              ],
            );
            clientWidgets.add(clientWidget);
          }
        }
        return  ListView(
            children: clientWidgets,
        );
      },
    );
  }
}
