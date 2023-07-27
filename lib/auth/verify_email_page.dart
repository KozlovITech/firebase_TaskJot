import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetrain2/Navigator.dart';
import 'package:firebasetrain2/component/custom-app_bar.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    setState(() => canResendEmail = false);
    await Future.delayed(
      (const Duration(seconds: 5)),
    );
    setState(() => canResendEmail = true);
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const MainNavigator()
      : Scaffold(
          body: Column(
            children: [
              const CustomAppBar(),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Confirm Your Email',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                child: Text(
                  "Thanks for signing up! To activate your account, please confirm your email address by clicking on the verification link we've sent to your email. Don't forget to check your spam folder if you can't find the email",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset('assets/img/cat_toDo.png',
                width: 350,
                height: 350,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50,50,50,35),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    icon: const Icon(
                      Icons.email,
                      size: 32,
                      color: Color.fromRGBO(218, 165, 32, 1),
                    ),
                    label: const Text(
                      'Resent Email',
                      style: TextStyle(
                        color: Color.fromRGBO(218, 165, 32, 1),
                      ),
                    ),
                    onPressed: canResendEmail ? sendVerificationEmail : null),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                    onPressed: signOut,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color.fromRGBO(218, 165, 32, 1),
                    ),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}
