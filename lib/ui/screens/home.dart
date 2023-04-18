import 'package:firebase_auth/firebase_auth.dart';
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
<<<<<<< Updated upstream
  String? userUID;
  String? userEmail;
  final _auth = FirebaseAuth.instance;
=======
  // String? userUID;
>>>>>>> Stashed changes
  @override
  void initState() {
    // _read();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

<<<<<<< Updated upstream
  _read() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'uid';
    // final value = prefs.getString(key) ?? "";
    final valueEmail = prefs.getString("email") ?? "";
    // debugPrint('read: $value');

    setState(() {
      // userUID = value.toString();
      userEmail = valueEmail.toString();
    });
  }
=======
  // _read() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   const key = 'uid';
  //   final value = prefs.getString(key);
  //   debugPrint('read: $value');
    

  //   setState(() {
  //     userUID = value.toString();
  //   });
  // }
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blue),
        // leading: Icon(
        //   Icons.person,
        //   color: blue,
        //   size: screenHeight(context, 30),
        // ),
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
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: blue,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: blue),
                accountName: const Text(
                  "Moiz Khan",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text(userEmail.toString()),
                currentAccountPictureSize: Size.square(50),
                // currentAccountPicture: CircleAvatar(
                //   backgroundColor: Color.fromARGB(255, 165, 255, 137),
                //   child: Text(
                //     "A",
                //     style: TextStyle(fontSize: 30.0, color: Colors.blue),
                //   ), //Text
                // ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.document_scanner_outlined),
              title: const Text(' Add Documents '),
              onTap: () {
                Navigator.pushNamed(context, "upload");
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share it'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("uid");
                _auth.signOut();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
        ),
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
                      imageUrl: data[index]["url"],
                      documentTitle: data[index]["title"],
                      onTap: () {
                        print(snapshot.data);
                      },
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
          // future: DatabaseService().getUser(userUID!)),
          future: DatabaseService().getUser()),
    );
  }
}
