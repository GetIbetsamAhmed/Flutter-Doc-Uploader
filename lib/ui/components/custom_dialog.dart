import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/custom_button.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';

class CustomPopUp extends StatelessWidget {
  final Function onButtonTap;
  final String buttonText, title, text;
  final bool closeDialogOnTap;
  const CustomPopUp({
    super.key,
    required this.onButtonTap,
    required this.buttonText,
    required this.text,
    required this.title,
    this.closeDialogOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (closeDialogOnTap) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: screenWidth(context, 295),
            padding: globalHorizontalPadding(context)
                .copyWith(bottom: screenHeight(context, 30)),
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(screenHeight(context, 40)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Center(
                  child: Container(
                    height: screenHeight(context, 140),
                    width: screenWidth(context, 140),
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(140),
                    ),
                    child: Icon(
                      Icons.person,
                      size: screenHeight(context, 90),
                      color: lightGrey,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight(context, 50)),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenHeight(context, 19),
                    color: blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight(context, 10)),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: screenHeight(context, 15),
                    color: textGrey,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                CustomButton(
                  color: blue,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  onTap: () {
                    Navigator.pop(context); 
                    onButtonTap();                    
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: lightGrey,
                      fontSize: screenHeight(context, 16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
