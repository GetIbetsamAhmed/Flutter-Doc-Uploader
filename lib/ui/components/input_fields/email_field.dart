import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';

class EmailField extends StatefulWidget {
  final TextEditingController emailController;
  final Function(String) onChanged;
  const EmailField({
    super.key,
    required this.emailController,
    required this.onChanged,
  });

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: blue,
      decoration: _emailDecorator(blue, context),
      onChanged: widget.onChanged,
    );
  }

  _emailDecorator(Color color, BuildContext context) {
    return InputDecoration(
      labelText: "Email",
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
    );
  }
}
