import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';

EdgeInsets globalHorizontalPadding(BuildContext context) =>
    EdgeInsets.symmetric(horizontal: screenWidth(context, 20));
