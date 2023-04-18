// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/custom_button.dart';
import 'package:flutter_firebase/ui/components/input_fields/email_field.dart';
import 'package:flutter_firebase/ui/components/input_fields/password_field.dart';
import 'package:flutter_firebase/ui/components/invalid_operation_dialog.dart';
import 'package:flutter_firebase/ui/components/loader_popup.dart';
import 'package:flutter_firebase/ui/components/remember_me.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController? _emailController, _passwordController;
  bool showPassword = false;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: globalHorizontalPadding(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight(context, 100)),
                Text(
                  "Hello There👋",
                  style: TextStyle(
                    fontSize: screenHeight(context, 35),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: screenHeight(context, 20)),
                Text(
                  "Please enter your email and password to sign in.",
                  style: TextStyle(
                    fontSize: screenHeight(context, 17),
                    fontWeight: FontWeight.w400,
                    wordSpacing: screenHeight(context, 2),
                    height: screenHeight(context, 2),
                  ),
                ),
                SizedBox(height: screenHeight(context, 50)),
                EmailField(
                  emailController: _emailController!,
                  onChanged: (val) {},
                ),
                SizedBox(height: screenHeight(context, 10)),
                PasswordField(
                  passwordController: _passwordController!,
                  onChanged: (val) {},
                ),
                SizedBox(height: screenHeight(context, 27)),
                const RememberMe(),
                SizedBox(height: screenHeight(context, 150)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot Your Password?",
                      style: TextStyle(
                        color: black,
                        fontSize: screenHeight(context, 17),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: screenWidth(context, 15)),
                    InkWell(
                      onTap: () async {
                        // _auth.sendPasswordResetEmail(
                        //   email: _emailController!.text.toString(),
                        // );
                        if (_emailController!.text.isNotEmpty) {
                          if (_emailController!.text.contains("@") &&
                              _emailController!.text.contains(".")) {
                            try {
                              await _auth.sendPasswordResetEmail(
                                email: _emailController!.text.toString(),
                              );
                              InvliadStatePopup.init(
                                context,
                                "A Password reset email has been sent to ${_emailController!.text}. Kindly check your email inbox.",
                                title: "Password Reset Email Sent",
                              );
                            } catch (e) {
                              InvliadStatePopup.init(
                                context,
                                e.toString().split("]")[1],
                                title: "User Not Found",
                              );
                            }
                          } else {
                            InvliadStatePopup.init(
                              context,
                              "Enter a valid Email",
                              title: "InValid Email",
                            );
                          }
                        } else {
                          InvliadStatePopup.init(
                            context,
                            "Please Enter Email to Proceed",
                            title: "Email Required For Forgot Password",
                          );
                        }
                      },
                      child: Text(
                        "Recover Password",
                        style: TextStyle(
                          color: blue,
                          fontSize: screenHeight(context, 17),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(context, 10)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New here?",
                      style: TextStyle(
                        color: black,
                        fontSize: screenHeight(context, 17),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: screenWidth(context, 10)),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "signup");
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: blue,
                          fontSize: screenHeight(context, 17),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(context, 100)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: globalHorizontalPadding(context)
              .copyWith(bottom: screenHeight(context, 30)),
          child: Consumer<DocumentProvider>(
            builder: (context, provider, _) => CustomButton(
              color: blue,
              width: MediaQuery.of(context).size.width,
              onTap: () async {
                _loginUser(provider);
              },
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: lightGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginUser(DocumentProvider provider) async {
    if (_emailController!.text.isNotEmpty &&
        _passwordController!.text.isNotEmpty) {
      if (_emailController!.text.contains("@") &&
          _emailController!.text.contains(".")) {
        try {
          Loader.show(context);
          final newUser = await _auth
              .signInWithEmailAndPassword(
            email: _emailController!.text.toString(),
            password: _passwordController!.text.toString(),
          )
              .whenComplete(() {
            Loader.disposeLoader(context);
          });
          // _save(newUser);
          provider.setUid(newUser.user!.uid);
          _saveUserEmail(newUser, provider);
          await Loader.showSuccessful(context);
          Navigator.pushNamed(context, 'home');
        } catch (e) {
          debugPrint(e.toString());
          bool userFound = true;
          if (e.toString().toLowerCase().contains("no user record")) {
            userFound = false;
          }

          InvliadStatePopup.init(
            context,
            userFound
                ? e.toString().split("]")[1]
                : "No user with such email and password found. Try re-entering the email and password",
            title: userFound ? "Invalid Attempt" : "User Not Found",
          );
        }
      } else {
        InvliadStatePopup.init(
          context,
          "Enter a valid Email",
          title: "InValid Email",
        );
      }
    } else {
      InvliadStatePopup.init(
        context,
        "email and password are required for sign in.",
        title: "Empty Required Fields",
      );
    }
  }

  // _save(UserCredential newUser) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   const key = 'uid';
  //   final value = newUser.user!.uid;
  //   prefs.setString(key, value);
  //   prefs.setString("email", newUser.user!.email!);
  //   debugPrint('saved $value');
  // }
  _saveUserEmail(UserCredential newUser, DocumentProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', newUser.user!.uid);
    provider.setUserEmail(newUser.user!.email!);
    provider.uid;
  }
}
