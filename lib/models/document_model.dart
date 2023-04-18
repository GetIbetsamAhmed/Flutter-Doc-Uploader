
class DocumentModel {
  String title, dataTime, uId, docId, imageURL;

  DocumentModel({
    required this.docId,
    required this.uId,
    required this.title,
    required this.dataTime,
    required this.imageURL,
  });

  @override
  String toString() {
    return "docID: $docId, uid: $uId, title: $title, dateTime: $dataTime, url: $imageURL";
  }
}
