
import 'package:echo_note/appwrite.dart';
import 'package:echo_note/editnotepage.dart';
import 'package:echo_note/homepage.dart';
import 'package:echo_note/note_data.dart';
import 'package:flutter/material.dart';

class Notepage extends StatefulWidget{
  @override
  final String id;
  final String title;
  final String content;
  const Notepage({super.key,required this.id,required this.title,required this.content});
  State<Notepage> createState()=> _notepageState();
}
class _notepageState extends State<Notepage>{

  late AppwriteService _appwriteService=AppwriteService();
  late List<notesData> _notes;

  Future<void> _deleteNoteDetatils(String taskId)async{
    try{
      await _appwriteService.deleteNote(taskId);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }catch(e){
      print("error deleting task:$e");
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        title: Text("${widget.title}",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Editnotepage(id: widget.id, title: widget.title, content: widget.content)));
          }, icon: Icon(Icons.edit,color: Colors.white,)),
          IconButton(onPressed: (){
            _deleteNoteDetatils(widget.id);
          }, icon: Icon(Icons.delete,color: Colors.white,)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("${widget.content}",style: TextStyle(fontSize: 20),),
      ),
    );
  }
}