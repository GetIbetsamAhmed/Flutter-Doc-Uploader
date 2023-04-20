// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/custom_button.dart';
import 'package:flutter_firebase/ui/components/custom_dialog.dart';
import 'package:flutter_firebase/ui/components/input_fields/email_field.dart';
import 'package:flutter_firebase/ui/components/input_fields/password_field.dart';
import 'package:flutter_firebase/ui/components/invalid_operation_dialog.dart';
import 'package:flutter_firebase/ui/components/remember_me.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController? _emailController,
      _passwordController,
      _confirmPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    _confirmPasswordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: globalHorizontalPadding(context),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight(context, 100)),
                Row(
                  children: [
                    Text(
                      "Create An Account",
                      style: TextStyle(
                        fontSize: screenHeight(context, 35),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: screenWidth(context, 5)),
                    Text(
                      "🔐",
                      style: TextStyle(
                        fontSize: screenHeight(context, 29),
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight(context, 20)),
                Text(
                  "Enter your email and password. If you forget it, then you have to forgot password.",
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
                SizedBox(height: screenHeight(context, 10)),
                PasswordField(
                  text: "Confirm Password",
                  passwordController: _confirmPasswordController!,
                  onChanged: (val) {},
                ),
                SizedBox(height: screenHeight(context, 27)),
                const RememberMe(),
                SizedBox(height: screenHeight(context, 100)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: globalHorizontalPadding(context)
              .copyWith(bottom: screenHeight(context, 30)),
          child: Consumer<DocumentProvider>(
            builder: (cotnext, provider, _) => CustomButton(
              color: blue,
              width: MediaQuery.of(context).size.width,
              onTap: () async {
                await _signUp(provider);
              },
              child: const Text(
                "Sign Up",
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

  _signUp(DocumentProvider provider) async {
    if (_emailController!.text.isNotEmpty &&
        _passwordController!.text.isNotEmpty &&
        _confirmPasswordController!.text.isNotEmpty) {
      try {
        if (_emailController!.text.contains("@") &&
            _emailController!.text.contains(".")) {
          if (_passwordController!.text == _confirmPasswordController!.text) {
            final newUser = await _auth.createUserWithEmailAndPassword(
                email: _emailController!.text.toString(),
                password: _passwordController!.text.toString());
            if (newUser != null) {
              // Navigator.pushNamed(context, 'home_screen');
              // _save(newUser);
              provider.setUid(newUser.user!.uid);
              _saveUserEmail(newUser, provider);
              showDialog(
                context: context,
                builder: (context) => CustomPopUp(
                  onButtonTap: () {
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  title: "Sign Up Successful!",
                  text: "Your account has been created",
                  buttonText: "Goto Home",
                ),
              );
            }
          } else {
            InvliadStatePopup.init(
              context,
              "Password and Confirm password must be same",
              title: "Mismatching Passwords",
            );
          }
        } else {
          InvliadStatePopup.init(
            context,
            "Enter a valid Email",
            title: "InValid Email",
          );
        }
      } catch (e) {
        debugPrint(e.toString());
        InvliadStatePopup.init(context, e.toString().split("]")[1]);
      }
    } else {
      InvliadStatePopup.init(
        context,
        "Email, Password and Confirm Password are required for sign up",
        title: "Empty Required Fields",
      );
    }
  }

  _saveUserEmail(UserCredential newUser, DocumentProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', newUser.user!.uid);
    provider.setUserEmail(newUser.user!.email!);
    provider.uid;
  }
}
