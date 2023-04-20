// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:flutter_firebase/ui/components/invalid_operation_dialog.dart';
import 'package:flutter_firebase/ui/components/loader_popup.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _imageFile;

  TextEditingController? titleController;
  @override
  void initState() {
    titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController!.dispose();
    super.dispose();
  }

  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  bool loading = false;
  Future uploadImageToFirebase(
      BuildContext context, String title, DocumentProvider provider) async {
    Loader.show(context);
    String fileName = _imageFile!.path;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) async => await DatabaseService().addData(
            uid: provider.uid,
            title: title,
            url: value,
            dateTime: DateTime.now().toString(),
            provider: provider,
          ),
        );
    primaryFocus!.unfocus();
    Loader.disposeLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<DocumentProvider>(
        builder: (context, docProvider, _) => Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
              width: context.width,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      docProvider.animateSearchToRight();
                      docProvider.setFloatingTappedCheck(false);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Text(
                    "Upload Document",
                    style: TextStyle(
                      color: black,
                      fontSize: screenHeight(context, 25),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(flex: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: context.width,
              padding: globalHorizontalPadding(context),
              child: TextFormField(
                controller: titleController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: "Title",
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
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: Colors.white,
                child: ClipRRect(
                  child: _imageFile != null
                      ? SizedBox(
                          height: screenHeight(context, 400),
                          child: Image.file(_imageFile!),
                        )
                      : ElevatedButton(
                          onPressed: pickImage,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(blue),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.add_a_photo),
                              SizedBox(width: screenWidth(context, 10)),
                              const Text("Add a photo")
                            ],
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _imageFile != null
                ? ElevatedButton(
                    onPressed: () async {
                      if (titleController!.text.isNotEmpty) {
                        await uploadImageToFirebase(
                            context, titleController!.text, docProvider);
                        titleController!.clear();
                        _imageFile = null;
                        docProvider.setFloatingTappedCheck(false);
                      } else {
                        InvliadStatePopup.init(
                          context,
                          "Title is a required field and must not be empty",
                          title: "Empty required field",
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue)),
                    child: Row(
                      children: [
                        const Icon(Icons.upload_sharp),
                        SizedBox(width: screenWidth(context, 10)),
                        const Text('Upload Image'),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
