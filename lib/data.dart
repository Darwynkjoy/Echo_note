import 'package:appwrite/models.dart';
class textsData{
  final String textid;
  final String title;
  final String content;

textsData({
  required this.textid,
  required this.title,
  required this.content,
});

factory textsData.fromDocument(Document doc){
  return textsData(textid: doc.$id,title: doc.data["title"], content: doc.data["content"]);
  } 
}

class tasksData{
  final String taskid;
  final String title;
  final String description;

  tasksData({
  required this.taskid,
  required this.title,
  required this.description,
});

factory tasksData.fromDocument(Document doc){
  return tasksData(taskid: doc.$id,title: doc.data["title"], description: doc.data["description"]);
  } 
}