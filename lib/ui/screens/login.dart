import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/custom_button.dart';
import 'package:flutter_firebase/ui/components/custom_dialog.dart';
import 'package:flutter_firebase/ui/components/input_fields/email_field.dart';
import 'package:flutter_firebase/ui/components/input_fields/password_field.dart';
import 'package:flutter_firebase/ui/components/remember_me.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              RememberMe(onTap: () {}),
              SizedBox(height: screenHeight(context, 50)),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: blue,
                      fontSize: screenHeight(context, 17),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: screenHeight(context, 25)),
              // Center(
              //   child: Text(
              //     "or, continue with",
              //     style: TextStyle(
              //       color: textGrey,
              //       fontSize: screenHeight(context, 17),
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
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
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => CustomPopUp(
                onButtonTap: () {
                  Navigator.pushReplacementNamed(context, 'home');
                },
                buttonText: "Goto Home",
                text: "Logged in Successful!",
                title: "Congratulations",
              ),
            );
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
    );
  }
}
