import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/ui/components/custom_button.dart';
import 'package:flutter_firebase/ui/components/custom_dialog.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';

Future<bool> onWillPop(
  DocumentProvider docProvider,
  BuildContext context,
  TextEditingController searchController,
) async {
  if (docProvider.isDrawerTapped) {
    docProvider.setDrawerTappedCheck(false);
  } else if (docProvider.isFloatingTapped) {
    docProvider.setFloatingTappedCheck(false);
  } else if (docProvider.showRenameWidget) {
    docProvider.hideRenameContainer();
  } else if (docProvider.isSearchTapped) {
    docProvider.setSearchTapped(false);
    searchController.clear();
    docProvider.clearSearchList();
  } else {
    await showDialog(
      context: context,
      builder: (context) => CustomPopUp(
        inscribedIcon: Icons.question_mark_rounded,
        onButtonTap: () {},
        firstButtonWidth: 4,
        secondButton: CustomButton(
          color: Colors.transparent,
          buttonBorder: Border.all(color: blue),
          width: MediaQuery.of(context).size.width / 3,
          height: 60,
          onTap: () {
            SystemNavigator.pop();
          },
          child: Text(
            "Exit The App",
            style: TextStyle(
              color: blue,
              fontSize: screenHeight(context, 16),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        buttonText: "Cancel",
        text: "Are you sure that you really wanna exit using the app",
        title: "Confirmation",
      ),
    );
  }
  return false;
}
