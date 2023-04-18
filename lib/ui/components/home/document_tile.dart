import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/custom_dialog.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/snackbar_management.dart';
import 'package:share_plus/share_plus.dart';

class DocumentTile extends StatefulWidget {
  final String imageUrl;
  final String documentTitle, dateTime;
  final Function() onTap;
  const DocumentTile({
    super.key,
    required this.imageUrl,
    required this.documentTitle,
    required this.dateTime,
    required this.onTap,
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        SnackBarsState.isSnackBarOpen = !SnackBarsState.isSnackBarOpen;
        return true;
      },
      child: GestureDetector(
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
              Container(
                width: screenHeight(context, 100),
                height: screenWidth(context, 110),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(screenHeight(context, 10)),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.imageUrl,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                // Image.network(
                //   "https://i.pinimg.com/474x/38/1e/d6/381ed64d7af7d54b8849091e3a9a505d--notebook-doodles-grunge-doodles-journals.jpg",
                //   fit: BoxFit.fill,
                // ),
                child: const Icon(Icons.image, color: noImageColor),
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
                      widget.documentTitle,
                      style: TextStyle(
                        fontSize: screenHeight(context, 18),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight(context, 10)),
                    Text(
                      widget.dateTime,
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
                          "${widget.imageUrl}\n${widget.documentTitle}",
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
                    child: PopupMenuButton(
                      onSelected: (value) async {
                        if (value == 'delete') {
                          await showDialog(
                            context: context,
                            builder: (context) => CustomPopUp(
                              onButtonTap: () {},
                              buttonText: "Delete",
                              text:
                                  "Are you sure that you wanna delete this document?",
                              title: "Confirmation",
                            ),
                          );
                        } else {
                          if (SnackBarsState.isSnackBarOpen) {
                            if(mounted)ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            SnackBarsState.isSnackBarOpen =
                                !SnackBarsState.isSnackBarOpen;
                          }
                          _renameWidget();
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _renameWidget() {
    Future.delayed(const Duration(seconds: 2), () {
      if(kDebugMode)  print("Snackbar closed");
      SnackBarsState.isSnackBarOpen = true;
    });
    SnackBarsState.isSnackBarOpen = true;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: white,
        content: TextField(
          controller: _renameController!,
          autofocus: true,
          onSubmitted: (val) {
            if(mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
            SnackBarsState.isSnackBarOpen = !SnackBarsState.isSnackBarOpen;
            debugPrint('Submitted text: ${_renameController!.text}');
            _renameController!.clear();
          },
          decoration: InputDecoration(
            focusColor: blue,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: blue, width: 1),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: blue, width: 1),
            ),
            labelStyle: TextStyle(
              color: black,
              fontSize: screenHeight(context, 17),
            ),
            hintText: 'Enter title',
          ),
        ),
        duration: const Duration(seconds: 1000),
        action: SnackBarAction(
          textColor: blue,
          label: 'Submit',
          onPressed: () {
            // Handle submit action here
            
            SnackBarsState.isSnackBarOpen = !SnackBarsState.isSnackBarOpen;
            debugPrint('Submitted text: ${_renameController!.text}');
            if(mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _renameController!.clear();
          },
        ),
      ),
    );
  }
}
