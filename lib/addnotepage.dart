import 'package:echo_note/appwrite.dart';
import 'package:echo_note/homepage.dart';
import 'package:echo_note/note_data.dart';
import 'package:flutter/material.dart';

class AddNotepage extends StatefulWidget{
  @override
  State<AddNotepage> createState()=> _addnoteState();
}

class _addnoteState extends State<AddNotepage>{

    TextEditingController titleContoller=TextEditingController();
    TextEditingController contentContoller=TextEditingController();

    late AppwriteService _appwriteService;
    late List<notesData> _notes;

  @override
  void initState(){
    super.initState;
    _appwriteService=AppwriteService();
    _notes=[];
    _loadNotesDetails();
  }

    Future <void> _loadNotesDetails()async{
    try{
      final task=await _appwriteService.getNoteDetails();
      setState(() {
        _notes=task.map((e)=> notesData.fromDocument(e)).toList();
      });
    }catch(e){
      print("error loading task: $e");
    }
  }

    Future<void>_addNotes()async{
    final title=titleContoller.text;
    final content=contentContoller.text;
    try{
      await _appwriteService.addNote(title,content);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }catch(e){
      print(e){
        print("error adding note:$e");
      }
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        title: Text("Add new note",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          IconButton(onPressed: (){
            _addNotes();
          }, icon: Icon(Icons.check,color: Colors.white,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //title text feild
            TextField(
              controller: titleContoller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 2,color: Colors.grey,style: BorderStyle.solid)
                 ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 2,color: const Color.fromARGB(255, 8, 179, 16),style: BorderStyle.solid)
                 ),
                labelText: "Title",
                labelStyle: TextStyle(color: const Color.fromARGB(255, 8, 179, 16),),
                ),
            ),
            SizedBox(height: 10,),
            //content textfeild
            SizedBox(
              height: 590,
              width: double.infinity,
              child: TextField(
                controller: contentContoller,
                decoration: InputDecoration(
                  //not in selection
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(width: 2,color: Colors.grey,style: BorderStyle.solid)
                   ),
                   //ontap 
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(width: 2,color: const Color.fromARGB(255, 8, 179, 16),style: BorderStyle.solid)
                   ),
                  labelText: "Content",
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 8, 179, 16),),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  alignLabelWithHint: true,
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: true,
                  
              ),
            )
          ],
        ),
      )
    );
  }
}