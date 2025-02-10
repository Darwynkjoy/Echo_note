import 'package:echo_note/appwrite.dart';
import 'package:echo_note/editnotepage.dart';
import 'package:echo_note/homepage.dart';
import 'package:flutter/material.dart';

class Textpage extends StatefulWidget{
  @override
  final String id;
  final String title;
  final String content;
  const Textpage({super.key,required this.id,required this.title,required this.content});
  State<Textpage> createState()=> _textpageState();
}
class _textpageState extends State<Textpage>{

  late AppwriteService _appwriteService=AppwriteService();

  Future<void> _deleteTextDetatils(String taskId)async{
    try{
      await _appwriteService.deleteText(taskId);
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Edittextpage(id: widget.id, title: widget.title, content: widget.content)));
          }, icon: Icon(Icons.edit,color: Colors.white,)),
          IconButton(onPressed: (){
            _deleteTextDetatils(widget.id);
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