import 'package:flutter/material.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:flutter_firebase/ui/components/home/document_tile.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? userUID;
  @override
  void initState() {
    super.initState();
    _read();
  }

  @override
  void dispose() {
    super.dispose();
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
        onPressed: () {
          Navigator.pushNamed(context, "upload");
        },
        backgroundColor: blue,
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
      body: FutureBuilder(
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                List<dynamic> data = snapshot.data;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => DocumentTile(
                      imageUrl:
                          data[index]["url"],
                      documentTitle: data[index]["title"],
                      onTap: () {},
                      dateTime: data[index]["dateTime"],
                    ),
                  ),
                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: DatabaseService().getUser(userUID!)),
    );
  }
}
