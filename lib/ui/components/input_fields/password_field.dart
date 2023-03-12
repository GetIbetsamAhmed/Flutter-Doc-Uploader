import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  final Function(String) onChanged;
  final String text;
  const PasswordField({
    super.key,
    required this.passwordController,
    required this.onChanged,
    this.text = "Password",
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      keyboardType: TextInputType.text,
      cursorColor: blue,
      decoration: _passwordDecorator(blue, context, () {
        setState(() {
          showPassword = !showPassword;
        });
      }, showPassword),
      obscureText: showPassword,
      onChanged: widget.onChanged,
    );
  }

  _passwordDecorator(
      Color color, BuildContext context, Function() onTap, bool showPassword) {
    return InputDecoration(
      labelText: widget.text,
      focusColor: color,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
      ),
      labelStyle: TextStyle(
        color: black,
        fontSize: screenHeight(context, 17),
      ),
      suffixIcon: InkWell(
        onTap: onTap,
        child: Icon(
          showPassword ? Icons.visibility_off : Icons.visibility,
          color: blue,
        ),
      ),
    );
  }
}
