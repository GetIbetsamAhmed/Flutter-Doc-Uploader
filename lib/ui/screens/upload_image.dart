import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _imageFile;
  String? userUID;
  String title = 'title';
  String? url;
  TextEditingController titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _read();
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'uid';
    final value = prefs.getString(key) ?? "";
    debugPrint('read: $value');

    setState(() {
      userUID = value.toString();
    });
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
      BuildContext context, TextEditingController titleController) async {
    setState(() {
      loading = true;
    });
    String fileName = _imageFile!.path;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) async => await DatabaseService().addData(
              uid: userUID!,
              title: titleController.text.toString(),
              url: value,
              dateTime: DateTime.now().toString()),
        );
    Navigator.popAndPushNamed(context, "home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: 'Enter title'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                  child: ClipRRect(
                    child: _imageFile != null
                        ? Image.file(_imageFile!)
                        : ElevatedButton(
                            onPressed: pickImage,
                            child: const Icon(Icons.add_a_photo),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _imageFile != null
                  ? ElevatedButton(
                      onPressed: () async {
                        uploadImageToFirebase(context, titleController);

                        // await DatabaseService().getUser(userUID!);
                        // final result = await DatabaseService().addData(
                        //     uid: userUID!, title: titleController.text.toString(), url: url!);
                        // if (result!.contains('success')) {
                        //   print('DATA PUSHED');
                        // }
                      },
                      child: const Text('Upload Image'),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
