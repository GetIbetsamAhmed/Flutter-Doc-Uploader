import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/dynamic_grid_sizes.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';

class AddImageContainer extends StatelessWidget {
  final DocumentProvider provider;
  const AddImageContainer({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textGrey.withOpacity(0.1),
        border: Border.all(color: textGrey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(
            getIconSizeForGrid(provider.getGridCrossAxisCount, context) / 20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_photo_alternate,
              size: screenHeight(context, 40),
                  // getIconSizeForGrid(provider.getGridCrossAxisCount, context) /
                  //     1.5,
              color: textGrey.withOpacity(0.5),
            ),
            SizedBox(height: screenHeight(context, 2)),
            Text(
              "Add Image",
              style: TextStyle(
                fontSize: getTextSizeForGrid(
                        provider.getGridCrossAxisCount, context) *
                    (provider.getGridCrossAxisCount == 5 ? 1 : 1.2),
                color: textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
