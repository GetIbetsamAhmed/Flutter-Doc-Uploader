import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/document_model.dart';
import 'package:flutter_firebase/ui/components/custom_dialog.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DocumentTile extends StatefulWidget {
  final DocumentModel document;
  final Function() onTap;
  final Function() onDeletePress;
  final int index;
  const DocumentTile({
    super.key,
    required this.document,
    required this.onTap,
    required this.onDeletePress,
    required this.index,
  });

  @override
  State<DocumentTile> createState() => _DocumentTileState();
}

class _DocumentTileState extends State<DocumentTile> {
  bool showOptions = false;
  TextEditingController? _renameController;

  @override
  void initState() {
    _renameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _renameController!.clear();
    super.dispose();
  }

  String formatCreateDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString()} ${_formatHours(dateTime.hour)}:${dateTime.minute.toString().padLeft(2, '0')} ${_getAmPm(dateTime.hour)} ${_getDayOfWeek(dateTime.weekday)}';
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _getAmPm(int hours) {
    return hours >= 12 ? 'PM' : 'AM';
  }

  String _formatHours(int hours) {
    if (hours == 0) {
      return '12';
    } else if (hours > 12) {
      return (hours - 12).toString().padLeft(2, '0');
    } else {
      return hours.toString().padLeft(2, '0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showOptions ? null : widget.onTap,
      child: Container(
        margin: globalHorizontalPadding(context)
            .copyWith(bottom: screenHeight(context, 10)),
        height: screenHeight(context, 120),
        padding: EdgeInsets.only(
          top: screenHeight(context, 05),
          bottom: screenHeight(context, 05),
          left: screenWidth(context, 10),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenHeight(context, 15)),
          color: dashbardContainerColor,
        ),
        child: Row(
          children: [
            // Container(
            //     decoration: BoxDecoration(
            //         borderRadius:
            //             BorderRadius.circular(screenHeight(context, 20)),
            //         color: blue),
            //     child:
            SizedBox(
              width: screenHeight(context, 100),
              height: screenWidth(context, 110),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(screenHeight(context, 10)),
                child: Image.network(
                  widget.document.imageURL,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Icon(Icons.image, size: 20, color: textGrey);
                    }
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: screenWidth(context, 10),
                  right: screenWidth(context, 10)),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.document.title,
                    style: TextStyle(
                      fontSize: screenHeight(context, 18),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight(context, 10)),
                  Text(
                    formatCreateDate(DateTime.parse(widget.document.dataTime)),
                    style: TextStyle(
                      fontSize: screenHeight(context, 11),
                      fontWeight: FontWeight.w500,
                      color: textGrey,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    await Share.share(
                        "${widget.document.imageURL}\n${widget.document.title}",
                        subject: "");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      left: 06,
                      right: 06,
                      bottom: 12,
                    ),
                    child: Icon(
                      Icons.share,
                      size: screenHeight(context, 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, 60),
                  width: screenWidth(context, 30),
                  child: Consumer<DocumentProvider>(
                    builder: (context, provider, _) => PopupMenuButton(
                      onSelected: (value) async {
                        if (value == 'delete') {
                          await showDialog(
                            context: context,
                            builder: (context) => CustomPopUp(
                              onButtonTap: widget.onDeletePress,
                              buttonText: "Delete",
                              text:
                                  "Are you sure that you wanna delete this document?",
                              title: "Confirmation",
                            ),
                          );
                        } else {
                          provider.showRenameContainer();
                          provider.setIndexOfCurrentTappedDocumentTile(
                              widget.index);
                        }
                      },
                      elevation: 0,
                      padding: const EdgeInsets.only(
                          top: 12.0, left: 0, right: 00, bottom: 12),
                      iconSize: screenHeight(context, 30),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "delete",
                          child: Row(
                            children: [
                              const Icon(
                                Icons.delete_forever,
                                color: textGrey,
                              ),
                              SizedBox(width: screenWidth(context, 10)),
                              Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: screenHeight(context, 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: "rename",
                          child: Row(
                            children: [
                              const Icon(
                                Icons.drive_file_rename_outline_outlined,
                                color: textGrey,
                              ),
                              SizedBox(width: screenWidth(context, 10)),
                              Text(
                                "Rename",
                                style: TextStyle(
                                  fontSize: screenHeight(context, 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // _renameWidget() {
  //   Future.delayed(const Duration(seconds: 2), () {
  //     if (kDebugMode) debugPrint("Snackbar closed");
  //     SnackBarsState.isSnackBarOpen = true;
  //   });
  //   SnackBarsState.isSnackBarOpen = true;
  //   return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       backgroundColor: white,
  //       content: TextField(
  //         controller: _renameController!,
  //         autofocus: true,
  //         onSubmitted: (val) {
  //           if (mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //           SnackBarsState.isSnackBarOpen = !SnackBarsState.isSnackBarOpen;
  //           debugPrint('Submitted text: ${_renameController!.text}');
  //           _renameController!.clear();
  //         },
  //         decoration: InputDecoration(
  //           focusColor: blue,
  //           enabledBorder: const UnderlineInputBorder(
  //             borderSide: BorderSide(color: blue, width: 1),
  //           ),
  //           focusedBorder: const UnderlineInputBorder(
  //             borderSide: BorderSide(color: blue, width: 1),
  //           ),
  //           labelStyle: TextStyle(
  //             color: black,
  //             fontSize: screenHeight(context, 17),
  //           ),
  //           hintText: 'Enter title',
  //         ),
  //       ),
  //       duration: const Duration(seconds: 1000),
  //       action: SnackBarAction(
  //         textColor: blue,
  //         label: 'Submit',
  //         onPressed: () {
  //           // Handle submit action here

  //           SnackBarsState.isSnackBarOpen = !SnackBarsState.isSnackBarOpen;
  //           debugPrint('Submitted text: ${_renameController!.text}');
  //           if (mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //           _renameController!.clear();
  //         },
  //       )));
  // }
}
