import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/home/document_tile.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.person,
          color: blue,
          size: screenHeight(context, 30),
        ),
        title: Text(
          "Flutter Scan",
          style: TextStyle(
            color: black,
            fontSize: screenHeight(context, 25),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: blue,
              size: screenHeight(context, 35),
            ),
          ),
          SizedBox(width: screenWidth(context, 10)),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: blue,
        child: const Icon(
          Icons.camera_alt_outlined,
          color: white,
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => DocumentTile(
          imageUrl:
              "https://i.pinimg.com/474x/38/1e/d6/381ed64d7af7d54b8849091e3a9a505d--notebook-doodles-grunge-doodles-journals.jpg",
          documentTitle: "Numberical Analysis Notes",
          onTap: () {},
          dateTime: "12/Mar/2023 04:00 PM Monday",
        ),
      ),
    );
  }
}
