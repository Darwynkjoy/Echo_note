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
  final String date;
  final String time;

  tasksData({
  required this.taskid,
  required this.title,
  required this.description,
  required this.date,
  required this.time
});

factory tasksData.fromDocument(Document doc){
  return tasksData(taskid: doc.$id,title: doc.data["title"], description: doc.data["description"],date: doc.data["date"],time: doc.data["time"]);
  } 
}

class listsData{
  //final String listid;
  final String title;
  final List<String> items;

listsData({
  //required this.listid,
  required this.title,
  required this.items,
});

factory listsData.fromDocument(Map<String,dynamic> doc){
  return listsData(

    title: doc['title'] as String,
    items: List<String>.from(doc['items']??[]));
  } 
}