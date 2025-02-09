import 'package:appwrite/models.dart';
class notesData{
  final String id;
  final String title;
  final String content;

notesData({
  required this.id,
  required this.title,
  required this.content,
});

factory notesData.fromDocument(Document doc){
  return notesData(id: doc.$id,title: doc.data["title"], content: doc.data["content"]);
  }

}
