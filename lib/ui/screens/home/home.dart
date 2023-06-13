// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/bottom_sheets/adjust_folder_size.dart';
import 'package:flutter_firebase/ui/components/bottom_sheets/change_folder_sorting.dart';
import 'package:flutter_firebase/ui/components/folder_screen/folder_container.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/dynamic_grid_sizes.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DocumentProvider provider = Provider.of<DocumentProvider>(context);
    return homeScreen(provider, context);
  }

  Widget homeScreen(DocumentProvider docProvider, BuildContext context) {
    // final DatabaseService databaseService = DatabaseService();
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
              GestureDetector(
                onTap: () {
                  docProvider.setSearchTapped(true);
                },
                child: Icon(
                  Icons.search,
                  color: blue,
                  size: screenHeight(context, 35),
                ),
              ),
              SizedBox(width: screenWidth(context, 15)),
              GestureDetector(
                onTap: () => showSortingSettingOption(context, docProvider),
                child: Icon(
                  Icons.sort_rounded,
                  color: blue,
                  size: screenHeight(context, 30),
                ),
              ),
              SizedBox(width: screenWidth(context, 15)),
              GestureDetector(
                onTap: () => showGridSizeSettingOption(context, docProvider),
                child: Icon(
                  Icons.grid_view,
                  color: blue,
                  size: screenHeight(context, 30),
                ),
              ),
              SizedBox(width: screenWidth(context, 10)),
            ],
          ),
        ),
        SizedBox(height: screenHeight(context, 10)),
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
              // : !docProvider.is
              //     ? ListView.builder(
              //         itemCount: docProvider.documentsCount() + 1,
              //         physics: const BouncingScrollPhysics(),
              //         itemBuilder: (context, index) =>
              //             index == docProvider.documentsCount()
              //                 ? Container(height: screenHeight(context, 140))
              //                 : DocumentTile(
              //                     document: docProvider.getDocument(index),
              //                     onTap: () {},
              //                     onDeletePress: () async {
              //                       Loader.show(context);
              //                       databaseService.deletteDocument(
              //                           index, docProvider);
              //                       Loader.disposeLoader(context);
              //                     },
              //                     index: index,
              //                   ),
              //       )
              : GridView.builder(
                  // itemCount: docProvider.documentsCount() + 1,
                  itemCount: docProvider.folderList.length,
                  physics: const BouncingScrollPhysics(),
                  padding: globalHorizontalPadding(context),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: docProvider.getGridCrossAxisCount,
                      mainAxisSpacing: screenWidth(context, 3),
                      crossAxisSpacing: screenWidth(context, 10),
                      mainAxisExtent: getIconSizeForGrid(
                              docProvider.getGridCrossAxisCount, context) +
                          10),
                  itemBuilder: (context, index) => FolderContainer(
                    folder: docProvider.folderList[index],
                    provider: docProvider,
                  ),
                ),
        ),
      ],
    );
  }
}
