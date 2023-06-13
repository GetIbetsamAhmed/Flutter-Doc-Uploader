import 'package:flutter_firebase/models/data_contract.dart';

class FolderModel implements DataModel {
  final String folderId;
  final String ancestorId;
  final String folderName;
  final DateTime createDate;
  final List<DataModel> folderData;

  const FolderModel({
    required this.folderId,
    required this.folderName,
    required this.ancestorId,
    required this.createDate,
    required this.folderData,
  });
}
