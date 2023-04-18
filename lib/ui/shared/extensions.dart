
import 'package:flutter/material.dart';

extension ExtractUserName on String {
  String extractUserNameFromEmail() {
    String userName = split("@")[0];
    return userName[0].toUpperCase() + userName.substring(1);
  }
}

extension ContextExtension on BuildContext {
  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }
}