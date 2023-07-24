import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetrain2/Navigator.dart';
import 'package:firebasetrain2/auth/verify_email_page.dart';
import 'package:flutter/material.dart';
import 'auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return VerifyEmailPage();
        }
        else{
          return AuthPage();
        }
      },
    );
  }
}
