// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

showSortingSettingOption(BuildContext context, DocumentProvider provider) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenWidth(context, 70),
            height: screenHeight(context, 2),
            color: blue,
          ),
          SizedBox(height: screenHeight(context, 25)),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth(context, 12),
                  bottom: screenHeight(context, 25)),
              child: Text(
                "Order Folders:",
                style: TextStyle(
                    color: black,
                    fontSize: screenHeight(context, 19),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt("folderSortingOrder", 1);
              provider.setFolderOrder(1);
              Navigator.pop(context);
            },
            title: Text(
              "By Folder Name (A-Z)",
              style: TextStyle(
                color: 1 == provider.getFolderOrder ? black : textGrey,
                fontSize: screenHeight(context, 17),
                fontWeight: 1 == provider.getFolderOrder
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
            minVerticalPadding: 10,
          ),
          ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt("folderSortingOrder", 2);
              provider.setFolderOrder(2);
              Navigator.pop(context);
            },
            title: Text(
              "By Folder Name (Z-A)",
              style: TextStyle(
                color: 2 == provider.getFolderOrder ? black : textGrey,
                fontSize: screenHeight(context, 17),
                fontWeight: 2 == provider.getFolderOrder
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
            minVerticalPadding: 10,
          ),
          ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt("folderSortingOrder", 3);
              provider.setFolderOrder(3);
              Navigator.pop(context);
            },
            title: Text(
              "By Create Date (Ascending Order)",
              style: TextStyle(
                color: 3 == provider.getFolderOrder ? black : textGrey,
                fontSize: screenHeight(context, 17),
                fontWeight: 3 == provider.getFolderOrder
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
            minVerticalPadding: 10,
          ),
          ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt("folderSortingOrder", 4);
              provider.setFolderOrder(4);
              Navigator.pop(context);
            },
            title: Text(
              "By Create Date (Descending Order)",
              style: TextStyle(
                color: 4 == provider.getFolderOrder ? black : textGrey,
                fontSize: screenHeight(context, 17),
                fontWeight: 4 == provider.getFolderOrder
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
