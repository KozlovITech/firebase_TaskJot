/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetStudentName extends StatelessWidget {
  const GetStudentName({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference cities =
        FirebaseFirestore.instance.collection('client');

    return FutureBuilder<QuerySnapshot>(
      // Отримання даних з колекції "cities"
      future: cities.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // Обробка помилок
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return const Text("No docuгments found");
        }

        // Виведення даних користувачу
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: snapshot.data!.docs.map((docSnapshot) {
              Map<String, dynamic> data =
                  docSnapshot.data() as Map<String, dynamic>;
              return
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          //Text('Name:'),
                          Text('${data['name']}'),
                        ],
                      ),
                      Column(
                        children: [
                         // Text('Email:'),
                          Text('${data['email']}'),
                        ],
                      ),
                      Column(
                        children: [
                         // Text('Mobile:'),
                          Text('${data['mobile']}'),
                        ],
                      ),
                    ],
                  );
              //Text("City: ${data['name']}");
            }).toList(),
          );
        }

        return const Text("Loading");
      },
    );
  }
}
*/