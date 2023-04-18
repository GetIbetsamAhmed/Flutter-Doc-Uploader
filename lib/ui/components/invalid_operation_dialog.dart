import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/custom_dialog.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';

class InvliadStatePopup {
  static init(BuildContext context, String text,
      {String title = "Invalid Operation", Function()? onTap}) {
    return showDialog(
      context: context,
      builder: (context) => CustomPopUp(
        onButtonTap: onTap ?? () {},
        buttonText: "Ok",
        title: title,
        text: text,
        icon: Icon(Icons.error, size: screenHeight(context, 160), color: blue),
        inscribedIcon: Icons.error,
        bottomSpace: 35,
        titleSize: 23,
        textSize: 16,
        textWeight: FontWeight.w500,
        
      ),
    );
  }
}
