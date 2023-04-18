import 'package:flutter/material.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:flutter_firebase/ui/components/home/document_tile.dart';
import 'package:flutter_firebase/ui/components/loader_popup.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';

Widget homeScreen(DocumentProvider docProvider, BuildContext context) {
  final DatabaseService databaseService = DatabaseService();
  return Column(
    children: [
      Container(
        height: kToolbarHeight,
        width: context.width,
        padding: globalHorizontalPadding(context).copyWith(right: 0),
        child: Row(
          children: [
            Container(width: screenWidth(context, 20)),
            const Spacer(flex: 1),
            Text(
              docProvider.appName,
              style: TextStyle(
                color: black,
                fontSize: screenHeight(context, 25),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(flex: 3),
            IconButton(
              onPressed: () {
                docProvider.setSearchTapped(true);
              },
              icon: Icon(
                Icons.search,
                color: blue,
                size: screenHeight(context, 35),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: context.height - kToolbarHeight,
        width: context.width,
        child: docProvider.getAllDocuments().isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(flex: 2),
                  Image.asset(
                    'assets/on_boarding/folder.png',
                    height: screenHeight(context, 175),
                  ),
                  Text(
                    "Your SnapBase is Empty",
                    style: TextStyle(
                      color: textGrey,
                      fontSize: screenHeight(context, 20),
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              )
            : ListView.builder(
                itemCount: docProvider.documentsCount() + 1,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => index ==
                        docProvider.documentsCount()
                    ? Container(height: screenHeight(context, 140))
                    : DocumentTile(
                        document: docProvider.getDocument(index),
                        onTap: () {},
                        onDeletePress: () async {
                          Loader.show(context);
                          databaseService.deletteDocument(index, docProvider);
                          Loader.disposeLoader(context);
                        },
                        index: index,
                      ),
              ),
      ),
    ],
  );
}
