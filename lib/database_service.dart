import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<String?> addData({
    required String? uid,
    required String? title,
    required String? url,
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('data_collection');
      // Call the user's CollectionReference to add a new user
      await users.add({'uid': uid, 'title': title, 'url': url});
      return 'success';
    } catch (e) {
      return 'Error adding data';
    }
  }

  Future<dynamic> getUser(String uid) async {
    List<dynamic> listMap = [];
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('data_collection');
      final snapshot = await users.where("uid", isEqualTo: uid).get().then(
        (querySnapshot) {
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            print('${docSnapshot.id} => ${docSnapshot.data()}');
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
