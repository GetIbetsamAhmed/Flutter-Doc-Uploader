import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/custom_button.dart';
import 'package:flutter_firebase/ui/components/custom_dialog.dart';
import 'package:flutter_firebase/ui/components/input_fields/email_field.dart';
import 'package:flutter_firebase/ui/components/input_fields/password_field.dart';
import 'package:flutter_firebase/ui/components/remember_me.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      body: Padding(
        padding: globalHorizontalPadding(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight(context, 20)),
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
              RememberMe(onTap: () {}),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: globalHorizontalPadding(context)
            .copyWith(bottom: screenHeight(context, 30)),
        child: CustomButton(
          color: blue,
          width: MediaQuery.of(context).size.width,
          onTap: () async {
            try {
              final newUser = await _auth.createUserWithEmailAndPassword(
                  email: _emailController!.text.toString(),
                  password: _passwordController!.text.toString());
              if (newUser != null) {
                // Navigator.pushNamed(context, 'home_screen');
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
            } catch (e) {
              debugPrint(e.toString());
            }
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
    );
  }
}
