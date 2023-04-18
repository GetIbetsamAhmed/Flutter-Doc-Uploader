// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/models/app_details_model.dart';
import 'package:flutter_firebase/models/document_model.dart';

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

  void removeDocFromSearch(String docId){
    int index = 0;
    for(int i = 0; i < searchList.length; i++){
      if(docId == searchList[i].docId){
        index = i;
        break;
      }
    }
    searchList.removeAt(index); 
    notifyListeners();
  }

  void renameDocTitleInSearch(String docId, String newTitle){
    int index = 0;
    for(int i = 0; i < searchList.length; i++){
      if(docId == searchList[i].docId){
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
}
