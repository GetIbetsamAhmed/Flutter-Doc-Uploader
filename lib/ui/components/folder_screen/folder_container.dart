import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/folder_model.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/screens/folder_screen.dart';
import 'package:flutter_firebase/ui/shared/dynamic_grid_sizes.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';

class FolderContainer extends StatelessWidget {
  final FolderModel folder;
  final DocumentProvider provider;
  const FolderContainer({
    super.key,
    required this.folder,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FolderScreen(folder: folder),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/on_boarding/folder.png',
                height: screenHeight(
                  context,
                  getIconSizeForGrid(provider.getGridCrossAxisCount, context),
                ),
                width: screenWidth(
                  context,
                  getIconSizeForGrid(provider.getGridCrossAxisCount, context),
                ),
              ),
              // Positioned(
              //   left: getIconSizeForGrid(
              //           provider.getGridCrossAxisCount, context) *
              //       0.333,
              //   top: getIconSizeForGrid(
              //           provider.getGridCrossAxisCount, context) *
              //       0.333,
              //   child: Text(
              //     folder.folderName[0],
              //     style: TextStyle(
              //       fontSize: getFirstLetterTextSize(
              //           provider.getGridCrossAxisCount, context),
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            ],
          ),
          // SizedBox(height: screenHeight(context, 10)),
          Text(
            folder.folderName,
            style: TextStyle(
              fontSize:
                  getTextSizeForGrid(provider.getGridCrossAxisCount, context),
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
