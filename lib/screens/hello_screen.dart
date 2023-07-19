import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HelloScreen extends StatefulWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  int _index = 0;

  void indexId(){
    setState(() {
      _index++;
    });
  }



  final user = FirebaseAuth.instance.currentUser!;

  
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final mobileController = TextEditingController();

    final screenHeight = MediaQuery.of(context).size.height;

    Future<void> addClient() async {
      await FirebaseFirestore.instance.collection('client')
          .doc('$_index').set({
        'name': nameController.text,
        'email': emailController.text,
        'mobile': mobileController.text,
      });
      indexId();
    }
    return Column(
      children: [
        ClipPath(
          clipper: WaveClipperOne(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff673ab7), Color(0xff9c27b0)],
                stops: [0.1, 1],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            height: 100,
            //color: Colors.deepPurple,
            child: const Center(child: Text("Note",style: TextStyle(fontSize:32,
            color: Colors.white,
            letterSpacing: 12),
            )),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                      hintText: 'Phone number',
                    ),
                  ),
                  const SizedBox(height: 25,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: addClient,
                      child: Container(
                        width: 200,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Add User',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                  const SizedBox(height: 10),


                  Text("Signed as: ${user.email!}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),),


                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
