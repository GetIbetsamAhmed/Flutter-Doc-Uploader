// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

showGridSizeSettingOption(BuildContext context, DocumentProvider provider) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(13),
        topRight: Radius.circular(13),
      ),
    ),
    builder: (context) => Padding(
      padding: globalHorizontalPadding(context).copyWith(
          top: screenHeight(context, 10), bottom: screenHeight(context, 20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenWidth(context, 70),
            height: screenHeight(context, 2),
            color: blue,
          ),
          SizedBox(height: screenHeight(context, 25)),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //         left: screenWidth(context, 12),
          //         bottom: screenHeight(context, 25)),
          //     child: Text(
          //       "Set fo",
          //       style: TextStyle(
          //           color: black,
          //           fontSize: screenHeight(context, 19),
          //           fontWeight: FontWeight.w600),
          //       textAlign: TextAlign.left,
          //     ),
          //   ),
          // ),
          for (int count = 2; count <= 5; count++)
            ListTile(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setInt("gridCrossAxisCount", count);
                provider.setGridCrossAxisCount(count);
                Navigator.pop(context);
              },
              title: Text(
                "${count}x$count",
                style: TextStyle(
                  color: count == provider.getGridCrossAxisCount
                      ? black
                      : textGrey,
                  fontSize: screenHeight(context, 17),
                  fontWeight: count == provider.getGridCrossAxisCount
                      ? FontWeight.w500
                      : FontWeight.w400,
                ),
              ),
              minVerticalPadding: 10,
            ),
        ],
      ),
    ),
  );
}
