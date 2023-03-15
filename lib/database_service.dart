import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  Future<String?> addData(
      {required String? uid,
      required String? title,
      required String? url,
      required String? dateTime}) async {
    try {
      CollectionReference data =
          FirebaseFirestore.instance.collection('data');
      // Call the user's CollectionReference to add a new user
      await data.add(
        {
          'uid': uid,
          'title': title,
          'url': url,
          'dateTime': dateTime
        },
      );
      return 'success';
    } catch (e) {
      return 'Error adding data';
    }
  }

  // Future<dynamic> getUser(String? uid) async {
  Future<dynamic> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'uid';
    final uid = prefs.getString(key) ?? "";
    // final valueEmail = prefs.getString("email") ?? "";
    debugPrint('read: $uid');
    List<dynamic> listMap = [];
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('data');
      // final snapshot =
      await users.where("uid", isEqualTo: uid).get().then(
        (querySnapshot) {
          debugPrint("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
            listMap.add(docSnapshot.data());
          }
        },
      );
      return listMap;
    } catch (e) {
      return 'Error fetching user';
    }
  }
}
