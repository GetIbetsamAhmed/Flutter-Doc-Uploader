import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/models/document_model.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  Future<String?> addData({
    required String? uid,
    required String? title,
    required String? url,
    required String? dateTime,
    required DocumentProvider provider,
  }) async {
    try {
      CollectionReference data = FirebaseFirestore.instance.collection('data');
      // Call the user's CollectionReference to add a new user
      await data.add(
        {'uid': uid, 'title': title, 'url': url, 'dateTime': dateTime},
      );
      await getAllDocuments(provider);
      return 'success';
    } catch (e) {
      return 'Error adding data';
    }
  }

  Future<dynamic> getAllDocuments(DocumentProvider provider) async {
    // debugPrint('read from getUser() uid : $uid');
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('data');
      provider.clearAllDocuments();

      await users.where("uid", isEqualTo: provider.uid).get().then(
        (querySnapshot) {
          debugPrint("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            var dataSnap = docSnapshot.data()! as Map;
            var docId = docSnapshot.id;
            var uid = dataSnap['uid'];
            var dateTime = dataSnap['dateTime'];
            var title = dataSnap['title'];
            var url = dataSnap['url'];

            var data = DocumentModel(
              docId: docId,
              uId: uid,
              title: title,
              dataTime: dateTime,
              imageURL: url,
            );

            debugPrint(
                "from getUser document ${provider.documentsCount() + 1} has ${data.toString()}");

            // setting data in provider
            provider.addDocument(data);
          }
        },
      );
      return "Data Fetched Successfully";
    } catch (e) {
      return 'Error fetching user';
    }
  }

  Future<dynamic> getAppDetails(DocumentProvider provider) async {
    debugPrint('read from getUser() uid : ${provider.uid}');
    try {
      CollectionReference appDetails =
          FirebaseFirestore.instance.collection('app_details');
      provider.clearAppDetails();

      await appDetails.get().then((querySnapShot) {
        for (var querySnapshot in querySnapShot.docs) {
          var dataSnap = querySnapshot.data()! as Map;
          var appVersion = dataSnap['app_version'];
          var developedBy = dataSnap['deveopled_by'];
          var appUrl = dataSnap['app_url'];

          provider.setAppDetails(
            appVersionInfo: appVersion.toString(),
            appDevInfo: developedBy.toString(),
            appUrl: appUrl.toString(),
          );
        }
      });
    } catch (e) {
      return 'Error fetching user';
    }
  }

  Future<dynamic> deletteDocument(int index, DocumentProvider provider) async {
    await FirebaseFirestore.instance
        .collection('data')
        .doc(provider.getDocument(index).docId)
        .delete();
    provider.removeDocument(index);
    if (provider.searchList.contains(provider.getDocument(index))) {
      provider.removeDocFromSearch(provider.getDocument(index).docId);
    }
    return "Successful";
  }

  Future<dynamic> renameDocument(
    DocumentProvider provider,
    String newDocumentName,
  ) async {
    Map<String, String> data = {
      "title": newDocumentName,
      "dateTime": DateTime.now().toString()
    };
    await FirebaseFirestore.instance
        .collection('data')
        .doc(provider.getDocument(provider.indexOfCurrentTappedDocTile).docId)
        .update(data);
    provider.renameDocument(
        newDocumentName, provider.indexOfCurrentTappedDocTile);
    if (provider.searchList
        .contains(provider.getDocument(provider.indexOfCurrentTappedDocTile))) {
      provider.renameDocTitleInSearch(
          provider.getDocument(provider.indexOfCurrentTappedDocTile).docId,
          newDocumentName);
    }
    return "Successful";
  }

  Future<dynamic> getUser(DocumentProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'uid';
// <<<<<<< Updated upstream
    final uid = prefs.getString(key) ?? "";
    // final valueEmail = prefs.getString("email") ?? "";
// =======
    // final uid = prefs.getString(key);
// >>>>>>> Stashed changes
    debugPrint('read: $uid');
    List<dynamic> listMap = [];
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('data');
      // final snapshot =
      // await users.where("uid", isEqualTo: uid).get().then(
      // CollectionReference users = FirebaseFirestore.instance.collection('data');
      provider.clearAllDocuments();
      // );

      await users.where("uid", isEqualTo: provider.uid).get().then(
        (querySnapshot) {
          debugPrint("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
            listMap.add(docSnapshot.data());
            var dataSnap = docSnapshot.data()! as Map;
            var docId = docSnapshot.id;
            var uid = dataSnap['uid'];
            var dateTime = dataSnap['dateTime'];
            var title = dataSnap['title'];
            var url = dataSnap['url'];

            var data = DocumentModel(
              docId: docId,
              uId: uid,
              title: title,
              dataTime: dateTime,
              imageURL: url,
            );

            debugPrint(
                "from getUser document ${provider.documentsCount() + 1} has ${data.toString()}");

            // setting data in provider
            provider.addDocument(data);
          }
        },
      );
      return "Data Fetched Successfully";
    } catch (e) {
      return 'Error fetching user';
    }
  }
}

//   Future<dynamic> getAppDetails(DocumentProvider provider) async {
//     debugPrint('read from getUser() uid : ${provider.uid}');
//     try {
//       CollectionReference appDetails =
//           FirebaseFirestore.instance.collection('app_details');
//       provider.clearAppDetails();

//       await appDetails.get().then((querySnapShot) {
//         for (var querySnapshot in querySnapShot.docs) {
//           var dataSnap = querySnapshot.data()! as Map;
//           var appVersion = dataSnap['app_version'];
//           var developedBy = dataSnap['deveopled_by'];
//           var appUrl = dataSnap['app_url'];

//           provider.setAppDetails(
//             appVersionInfo: appVersion.toString(),
//             appDevInfo: developedBy.toString(),
//             appUrl: appUrl.toString(),
//           );
//         }
//       });
//     } catch (e) {
//       return 'Error fetching user';
//     }
//   }

//   Future<dynamic> deletteDocument(int index, DocumentProvider provider) async {
//     await FirebaseFirestore.instance
//         .collection('data')
//         .doc(provider.getDocument(index).docId)
//         .delete();
//     provider.removeDocument(index);
//     if (provider.searchList.contains(provider.getDocument(index))) {
//       provider.removeDocFromSearch(provider.getDocument(index).docId);
//     }
//     return "Successful";
//   }

//   Future<dynamic> renameDocument(
//     DocumentProvider provider,
//     String newDocumentName,
//   ) async {
//     Map<String, String> data = {
//       "title": newDocumentName,
//       "dateTime": DateTime.now().toString()
//     };
//     await FirebaseFirestore.instance
//         .collection('data')
//         .doc(provider.getDocument(provider.indexOfCurrentTappedDocTile).docId)
//         .update(data);
//     provider.renameDocument(
//         newDocumentName, provider.indexOfCurrentTappedDocTile);
//     if (provider.searchList
//         .contains(provider.getDocument(provider.indexOfCurrentTappedDocTile))) {
//       provider.renameDocTitleInSearch(
//           provider.getDocument(provider.indexOfCurrentTappedDocTile).docId,
//           newDocumentName);
//     }
//     return "Successful";
//   }
// }


// Future<dynamic> getUser(String? uid) async {
