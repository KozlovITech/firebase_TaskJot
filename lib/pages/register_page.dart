import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../component/custom-app_bar.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future signUp() async {
    if(passwordConfirmed()){
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      FirebaseFirestore.instance.
      collection("Users").
      doc(userCredential.user!.email).
      set({
        'username' : _emailController.text.split('@')[0],
        'bio': 'Empty bio..',
        'mobile phone': '+38065'
      });

    } else{
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool passwordConfirmed() {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password == confirmPassword) {
      if (password.length >= 6) {
        return true;
      } else {
        // Password length is less than 6 characters
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password must be at least 6 characters long')),
        );
        return false;
      }
    } else {
      // Passwords don't match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAppBar(),
            const SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.only(left: 65),
              child: Image.asset('assets/img/log.png',
                width: 200,
                height: 200,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'REGISTER',
              style: TextStyle(fontSize: 48,
                fontFamily: 'Poppins',),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Register below!',
              style: TextStyle(fontSize: 20,
                fontFamily: 'Poppins',),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: 'Email',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //password field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: 'Password',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                obscureText: true,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: 'Confirm password',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: signUp,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color.fromRGBO(218, 165, 32, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('I am a member? '),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Color.fromRGBO(218, 165, 32, 1),
                      fontFamily: 'Roboto',),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}