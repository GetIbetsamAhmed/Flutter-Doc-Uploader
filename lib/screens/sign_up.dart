// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Enter your email'),
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: 'Enter your password'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading=true;
                    });
                    try {
                      // final newUser = 
                      await _auth.createUserWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString());
                      // if (newUser != null) {
                        Navigator.pushNamed(context, 'home_screen');
                      // }
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                    setState(() {
                      loading=false;
                    });
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
