// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:flutter_firebase/ui/components/invalid_operation_dialog.dart';
import 'package:flutter_firebase/ui/components/loader_popup.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';

renameWidget(BuildContext context, TextEditingController renameController,
    DocumentProvider docProvider) {
  return Padding(
    padding: globalHorizontalPadding(context),
    child: Row(
      children: [
        SizedBox(
          width: context.width - screenWidth(context, 80),
          child: TextFormField(
            controller: renameController,
            cursorColor: blue,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: "Title",
              focusColor: blue,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                color: textGrey,
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send_sharp, color: blue),
          onPressed: () async {
            if (renameController.text.isNotEmpty) {
              Loader.show(context);

              await DatabaseService()
                  .renameDocument(docProvider, renameController.text);
              Loader.disposeLoader(context);
              renameController.clear();
              docProvider.hideRenameContainer();

              primaryFocus!.unfocus();
            } else {
              InvliadStatePopup.init(
                context,
                "Title is a required field and must not be empty",
                title: "Empty required field",
              );
            }
          },
        ),
      ],
    ),
  );
}
