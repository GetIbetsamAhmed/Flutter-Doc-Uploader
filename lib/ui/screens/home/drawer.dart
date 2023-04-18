// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


drawer({required double width, required DocumentProvider provider,required BuildContext context}) {
    return Container(
      height: context.height,
      width: width,
      color: white, 
      padding: EdgeInsets.only(bottom: screenHeight(context, 70)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.height / 3,
            color: blue,
            width: width,
            padding: globalHorizontalPadding(context)
                .copyWith(bottom: screenHeight(context, 25)),
            margin: EdgeInsets.only(bottom: screenHeight(context, 30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "WELCOME",
                  style: TextStyle(
                    color: white,
                    fontSize: screenHeight(context, 15),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: screenHeight(context, 05)),
                Text(
                  provider.getUserEmail.extractUserNameFromEmail(),
                  style: TextStyle(
                    color: white,
                    fontSize: screenHeight(context, 25),
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenHeight(context, 05)),
                Text(
                  "@${provider.appName.toLowerCase()}",
                  style: TextStyle(
                    color: white,
                    fontSize: screenHeight(context, 16),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight(context, 05)),
                Text(
                  "${provider.appName} is a app in which you can save your important snaps and attach a title to them, protected by your login credentials.",
                  style: TextStyle(
                    color: white,
                    fontSize: screenHeight(context, 11),
                    fontWeight: FontWeight.w300,
                    wordSpacing: screenWidth(context, 3),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight(context, 60),
            width: width,
            padding: globalHorizontalPadding(context),
            child: InkWell(
              onTap: () {
                provider.setDrawerTappedCheck(false);
                provider.setFloatingTappedCheck(true);
              },
              child: Row(
                children: [
                  Icon(Icons.document_scanner_outlined,
                      size: screenHeight(context, 25)),
                  SizedBox(width: screenWidth(context, 10)),
                  const Text("Upload New Document"),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight(context, 10)),
          Container(
            height: screenHeight(context, 60),
            width: width,
            padding: globalHorizontalPadding(context),
            child: InkWell(
              onTap: () {
                provider.setDrawerTappedCheck(false);
                Share.share(
                    "${provider.getAppDetails.appUrl}\nDownload App Now. Current App Version is ${provider.getAppDetails.appVersion}");
              },
              child: Row(
                children: [
                  Icon(Icons.share, size: screenHeight(context, 25)),
                  SizedBox(width: screenWidth(context, 10)),
                  const Text("Share The App"),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight(context, 10)),
          Container(
            height: screenHeight(context, 60),
            width: width,
            padding: globalHorizontalPadding(context),
            child: InkWell(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("uid");
                pref.remove("email");
                // _auth.signOut();
                provider.setDrawerTappedCheck(false);
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: Row(
                children: [
                  Icon(Icons.logout, size: screenHeight(context, 25)),
                  SizedBox(width: screenWidth(context, 10)),
                  const Text("Logout"),
                ],
              ),
            ),
          ),
          const Spacer(flex: 4),
          Container(
            width: width,
            padding: globalHorizontalPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Version ",
                      style: TextStyle(
                          fontSize: screenWidth(context, 13), color: textGrey),
                    ),
                    Text(
                      provider.getAppDetails.appVersion,
                      style: TextStyle(
                        fontSize: screenWidth(context, 13),
                        color: blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(context, 05)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Powered By: ",
                      style: TextStyle(
                          fontSize: screenWidth(context, 13), color: textGrey),
                    ),
                    Text(
                      provider.getAppDetails.appDeveloperInfo,
                      style: TextStyle(
                        fontSize: screenWidth(context, 13),
                        color: blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // const Spacer(flex: 2),
        ],
      ),
    );
  }

