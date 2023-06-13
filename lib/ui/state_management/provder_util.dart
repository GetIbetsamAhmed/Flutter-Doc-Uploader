// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/models/app_details_model.dart';
import 'package:flutter_firebase/models/document_model.dart';
import 'package:flutter_firebase/models/folder_model.dart';

class DocumentProvider extends ChangeNotifier {
  String _uid = "";
  String get uid => _uid;
  void setUid(String id) {
    _uid = id;
    notifyListeners();
  }

  String appName = "Snapbase";

  // Managing all documents
  List<DocumentModel> _documents = [];
  DocumentModel getDocument(int index) => _documents[index];
  List<DocumentModel> getAllDocuments() => _documents;
  void addDocument(DocumentModel document) {
    _documents.add(document);
    notifyListeners();
  }

  void clearAllDocuments() {
    _documents = [];
    // notifyListeners();
  }

  void removeDocument(int index) {
    _documents.removeAt(index);
    notifyListeners();
  }

  void renameDocument(String name, int index) {
    _documents[index].title = name;
    _documents[index].dataTime = DateTime.now().toString();
    notifyListeners();
  }

  int documentsCount() => _documents.length;

  String _userEmail = "";
  String get getUserEmail => _userEmail;

  void setUserEmail(String userEmailFetched) {
    _userEmail = userEmailFetched;
    notifyListeners();
  }

  AppDetailsModel _appDetails = const AppDetailsModel(
    appUrl: "",
    appVersion: "",
    appDeveloperInfo: "",
  );

  AppDetailsModel get getAppDetails => _appDetails;
  void setAppDetails(
      {required String appVersionInfo,
      required String appDevInfo,
      required String appUrl}) {
    _appDetails = AppDetailsModel(
      appUrl: appUrl,
      appVersion: appVersionInfo,
      appDeveloperInfo: appDevInfo,
    );
    notifyListeners();
  }

  void clearAppDetails() {
    _appDetails = const AppDetailsModel(
      appUrl: "",
      appVersion: "",
      appDeveloperInfo: "",
    );
    notifyListeners();
  }

  bool _isDrawerTapped = false;
  bool _isfloatingTapped = false;

  bool get isDrawerTapped => _isDrawerTapped;
  void setDrawerTappedCheck(bool check) {
    hideRenameContainer();
    _isDrawerTapped = check;
    notifyListeners();
  }

  bool _shouldAnimatedSearchToLeft = false;
  void animateSearchToLeft() {
    _shouldAnimatedSearchToLeft = true;
    notifyListeners();
  }

  bool get getAnimateSearchToLeft => _shouldAnimatedSearchToLeft;
  void animateSearchToRight() {
    _shouldAnimatedSearchToLeft = false;
    notifyListeners();
  }

  bool get isFloatingTapped => _isfloatingTapped;
  void setFloatingTappedCheck(bool check) {
    hideRenameContainer();
    _isfloatingTapped = check;
    notifyListeners();
  }

  bool showRenameWidget = false;
  void showRenameContainer() {
    showRenameWidget = true;
    notifyListeners();
  }

  void hideRenameContainer() {
    showRenameWidget = false;
    notifyListeners();
  }

  int _indexOfCurrentTappedDocTile = 0;

  void setIndexOfCurrentTappedDocumentTile(int index) {
    _indexOfCurrentTappedDocTile = index;
  }

  int get indexOfCurrentTappedDocTile => _indexOfCurrentTappedDocTile;

  bool rememberMe = true;
  void changeRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  bool isSearchTapped = false;
  void setSearchTapped(bool value) {
    hideRenameContainer();
    isSearchTapped = value;
    notifyListeners();
  }

  List<DocumentModel> searchList = [];

  void clearSearchList() {
    searchList.clear();
    notifyListeners();
  }

  void removeDocFromSearch(String docId) {
    int index = 0;
    for (int i = 0; i < searchList.length; i++) {
      if (docId == searchList[i].docId) {
        index = i;
        break;
      }
    }
    searchList.removeAt(index);
    notifyListeners();
  }

  void renameDocTitleInSearch(String docId, String newTitle) {
    int index = 0;
    for (int i = 0; i < searchList.length; i++) {
      if (docId == searchList[i].docId) {
        index = i;
        break;
      }
    }
    searchList[index].title = newTitle;
    notifyListeners();
  }

  void search(String val) {
    searchList = _documents
        .where(
          (e) =>
              e.title.toString().toLowerCase().contains(val.toLowerCase()) ||
              e.dataTime.toString().toLowerCase().contains(val.toLowerCase()),
        )
        .toList();
    notifyListeners();
  }

  int _gridValue = 3;
  int get getGridCrossAxisCount => _gridValue;
  void setGridCrossAxisCount(int count) {
    _gridValue = count;
    notifyListeners();
  }

  int _folderOrder = 1;
  int get getFolderOrder => _folderOrder;
  void setFolderOrder(int count) {
    _folderOrder = count;
    sortFolders();
    notifyListeners();
  }

  List<String> imageList = [
    "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://thumbs.dreamstime.com/b/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg",
    "https://1.bp.blogspot.com/-kK7Fxm7U9o0/YN0bSIwSLvI/AAAAAAAACFk/aF4EI7XU_ashruTzTIpifBfNzb4thUivACLcBGAsYHQ/s1280/222.jpg",
    "https://burst.shopifycdn.com/photos/woman-dressed-in-white-leans-against-a-wall.jpg?width=1200&format=pjpg&exif=0&iptc=0",
    "https://as2.ftcdn.net/v2/jpg/05/56/62/81/1000_F_556628175_ef7a36I7nFxIQyuMwXORYdL9HsSddhoW.jpg",
    "https://imgd.aeplcdn.com/1056x594/n/cw/ec/44686/activa-6g-right-front-three-quarter.jpeg?q=75",
    "https://images.freeimages.com/images/previews/ac9/railway-hdr-1361893.jpg",
    "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://thumbs.dreamstime.com/b/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg",
    "https://1.bp.blogspot.com/-kK7Fxm7U9o0/YN0bSIwSLvI/AAAAAAAACFk/aF4EI7XU_ashruTzTIpifBfNzb4thUivACLcBGAsYHQ/s1280/222.jpg",
    "https://burst.shopifycdn.com/photos/woman-dressed-in-white-leans-against-a-wall.jpg?width=1200&format=pjpg&exif=0&iptc=0",
    "https://as2.ftcdn.net/v2/jpg/05/56/62/81/1000_F_556628175_ef7a36I7nFxIQyuMwXORYdL9HsSddhoW.jpg",
    "https://imgd.aeplcdn.com/1056x594/n/cw/ec/44686/activa-6g-right-front-three-quarter.jpeg?q=75",
    "https://images.freeimages.com/images/previews/ac9/railway-hdr-1361893.jpg",
    "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://thumbs.dreamstime.com/b/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg",
    "https://1.bp.blogspot.com/-kK7Fxm7U9o0/YN0bSIwSLvI/AAAAAAAACFk/aF4EI7XU_ashruTzTIpifBfNzb4thUivACLcBGAsYHQ/s1280/222.jpg",
    "https://burst.shopifycdn.com/photos/woman-dressed-in-white-leans-against-a-wall.jpg?width=1200&format=pjpg&exif=0&iptc=0",
    "https://as2.ftcdn.net/v2/jpg/05/56/62/81/1000_F_556628175_ef7a36I7nFxIQyuMwXORYdL9HsSddhoW.jpg",
    "https://imgd.aeplcdn.com/1056x594/n/cw/ec/44686/activa-6g-right-front-three-quarter.jpeg?q=75",
    "https://images.freeimages.com/images/previews/ac9/railway-hdr-1361893.jpg",
    "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://thumbs.dreamstime.com/b/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg",
    "https://1.bp.blogspot.com/-kK7Fxm7U9o0/YN0bSIwSLvI/AAAAAAAACFk/aF4EI7XU_ashruTzTIpifBfNzb4thUivACLcBGAsYHQ/s1280/222.jpg",
    "https://burst.shopifycdn.com/photos/woman-dressed-in-white-leans-against-a-wall.jpg?width=1200&format=pjpg&exif=0&iptc=0",
    "https://as2.ftcdn.net/v2/jpg/05/56/62/81/1000_F_556628175_ef7a36I7nFxIQyuMwXORYdL9HsSddhoW.jpg",
    "https://imgd.aeplcdn.com/1056x594/n/cw/ec/44686/activa-6g-right-front-three-quarter.jpeg?q=75",
    "https://images.freeimages.com/images/previews/ac9/railway-hdr-1361893.jpg",
    // "",
    // "",
    // "",
  ];

  List<FolderModel> folderList = [
    // "Assignments",
    // "Future",
    // "Interview Questions",
    // "Practice Problems",
    // "Data bank",
    // "GF pics",
    FolderModel(
      folderId: "",
      folderName: "Assignments",
      ancestorId: "",
      createDate: DateTime.now(),
      folderData: [],
    ),
    FolderModel(
      folderId: "",
      folderName: "Future",
      ancestorId: "",
      createDate: DateTime.now(),
      folderData: [],
    ),
    FolderModel(
      folderId: "",
      folderName: "Interview Questions",
      ancestorId: "",
      createDate: DateTime.now(),
      folderData: [],
    ),
    FolderModel(
      folderId: "",
      folderName: "Practice Problems",
      ancestorId: "",
      createDate: DateTime.now(),
      folderData: [],
    ),
    FolderModel(
      folderId: "",
      folderName: "Data bank",
      ancestorId: "",
      createDate: DateTime.now(),
      folderData: [],
    ),
    FolderModel(
      folderId: "",
      folderName: "GF pics",
      ancestorId: "",
      createDate: DateTime.now(),
      folderData: [],
    ),
  ];

  sortFolders() {
    if (_folderOrder == 1) {
      folderList.sort((a, b) => a.folderName.compareTo(b.folderName));
    } else if (_folderOrder == 2) {
      folderList.sort((a, b) => b.folderName.compareTo(a.folderName));
    } else if (_folderOrder == 3) {
      folderList.sort((a, b) => a.createDate.compareTo(b.createDate));
    } else if (_folderOrder == 4) {
      folderList.sort((a, b) => b.createDate.compareTo(a.createDate));
    }
    // notifyListeners();
  }

  bool _folderSearchWidget = false;
  bool get getFolderSearch => _folderSearchWidget;
  void setFolderSearch(bool val) {
    _folderSearchWidget = val;
    notifyListeners();
  }

  List<Map<String, int>> get getCallCount => _callCount;
  List<Map<String, int>> _callCount = [
    {
      "mainAxis": 6,
      "crossAxis": 6,
    },
    {
      "mainAxis": 3,
      "crossAxis": 3,
    },
    {
      "mainAxis": 3,
      "crossAxis": 3,
    },
    {
      "mainAxis": 3,
      "crossAxis": 2,
    },
    {
      "mainAxis": 3,
      "crossAxis": 2,
    },
    {
      "mainAxis": 3,
      "crossAxis": 2,
    },
    {
      "mainAxis": 3,
      "crossAxis": 3,
    },
    {
      "mainAxis": 3,
      "crossAxis": 3,
    },
    {
      "mainAxis": 6,
      "crossAxis": 6,
    },
    {
      "mainAxis": 3,
      "crossAxis": 2,
    },
    {
      "mainAxis": 3,
      "crossAxis": 2,
    },
    {
      "mainAxis": 3,
      "crossAxis": 2,
    },
  ];

  int get getStaggeredCrossCount => 12;

}
