import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter/material.dart';

double getFirstLetterTextSize(int crossAxisCount, BuildContext context) {
    switch (crossAxisCount) {
      case 2:
        return screenHeight(context, 24);
      case 3:
        return screenHeight(context, 20);
      case 4:
        return screenHeight(context, 16);
      default:
        return screenHeight(context, 12);
    }
  }

  double getTextSizeForGrid(int crossAxisCount, BuildContext context) {
    switch (crossAxisCount) {
      case 2:
        return screenHeight(context, 16);
      case 3:
        return screenHeight(context, 14);
      default:
        return screenHeight(context, 12);
    }
  }

  double getIconSizeForGrid(int crossAxisCount, BuildContext context) {
    switch (crossAxisCount) {
      case 2:
        return screenHeight(context, 150);
      case 3:
        return screenHeight(context, 100);
      case 4:
        return screenHeight(context, 80);
      default:
        return screenHeight(context, 60);
    }
  }