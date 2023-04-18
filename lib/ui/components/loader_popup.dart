import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';

class Loader {
  static show(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
          const Center(child: CircularProgressIndicator(color: blue)),
    );
  }

  static disposeLoader(context) {
    Navigator.pop(context);
  }

  static showSuccessful(context, {double size = 60}) {
    // Navigator.pop(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: Container(
          height: screenHeight(context, size),
          width: screenHeight(context, size),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenHeight(context, size)),
            color: blue,
          ),
          child: const Center(child: Icon(Icons.done, color: white)),
        ),
      ),
    );
    Future.delayed(const Duration(milliseconds: 400));
    Navigator.pop(context);
  }
}
