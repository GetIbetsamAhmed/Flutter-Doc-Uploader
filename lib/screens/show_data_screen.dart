// // import 'package:flutter/material.dart';
// // import 'package:flutter_firebase/database_service.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class ShowDataScreen extends StatefulWidget {
// //   const ShowDataScreen({super.key});

// //   @override
// //   State<ShowDataScreen> createState() => _ShowDataScreenState();
// // }

// <<<<<<< Updated upstream
// <<<<<<< Updated upstream
// class _ShowDataScreenState extends State<ShowDataScreen> {
//   String? userUID;
//   @override
//   void initState() {
//     super.initState();
//     // _read();
//   }
// =======
// =======
// >>>>>>> Stashed changes
// // class _ShowDataScreenState extends State<ShowDataScreen> {
// //   String? userUID;
// //   @override
// //   void initState() {
// //     super.initState();
// //     _read();
// //   }
// <<<<<<< Updated upstream
// >>>>>>> Stashed changes
// =======
// >>>>>>> Stashed changes

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('All Data'),
// //         ),
// //         body: FutureBuilder(
// //             builder: (ctx, snapshot) {
// //               // Checking if future is resolved or not
// //               if (snapshot.connectionState == ConnectionState.done) {
// //                 // If we got an error
// //                 if (snapshot.hasError) {
// //                   return Center(
// //                     child: Text(
// //                       '${snapshot.error} occurred',
// //                       style: const TextStyle(fontSize: 18),
// //                     ),
// //                   );

// //                   // if we got our data
// //                 } else if (snapshot.hasData) {
// //                   // Extracting data from snapshot object
// //                   List<dynamic> data = snapshot.data;
// //                   return SizedBox(
// //                     height: MediaQuery.of(context).size.height,
// //                     width: MediaQuery.of(context).size.width,
// //                     child: ListView.builder(
// //                         itemCount: data.length,
// //                         itemBuilder: (BuildContext context, int index) {
// //                           return Row(
// //                             mainAxisAlignment: MainAxisAlignment.start,
// //                             children: [
// //                               Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 children: [
// //                                   Text(
// //                                     data[index]["title"],
// //                                     style: const TextStyle(
// //                                       fontSize: 20,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                                   SizedBox(
// //                                     width: MediaQuery.of(context).size.width,
// //                                     child: Image(
// //                                       image: NetworkImage(data[index]["url"]),
// //                                     ),
// //                                   ),
// //                                   const SizedBox(
// //                                     height: 10,
// //                                   ),
// //                                 ],
// //                               )
// //                             ],
// //                           );
// //                         }),
// //                   );
// //                 }
// //               }

// //               return const Center(
// //                 child: CircularProgressIndicator(),
// //               );
// //             },
// //             // future: DatabaseService().getUser(userUID!)),
// //             future: DatabaseService().getUser()),
// //       ),
// //     );
// //   }

// <<<<<<< Updated upstream
// <<<<<<< Updated upstream
//   // _read() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   const key = 'uid';
//   //   final value = prefs.getString(key) ?? "";
//   //   debugPrint('read: $value');

//   //   setState(() {
//   //     userUID = value.toString();
//   //   });
//   // }
// }
// =======
// //   _read() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     const key = 'uid';
// //     final value = prefs.getString(key) ?? "";
// //     debugPrint('read: $value');

// =======
// //   _read() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     const key = 'uid';
// //     final value = prefs.getString(key) ?? "";
// //     debugPrint('read: $value');

// >>>>>>> Stashed changes
// //     setState(() {
// //       userUID = value.toString();
// //     });
// //   }
// // }
// <<<<<<< Updated upstream
// >>>>>>> Stashed changes
// =======
// >>>>>>> Stashed changes
