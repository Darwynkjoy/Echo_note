import 'package:echo_note/appwrite.dart';
import 'package:echo_note/notepage.dart';
import 'package:flutter/material.dart';

class Editnotepage extends StatefulWidget{
  @override
  final String id;
  final String title;
  final String content;
  const Editnotepage({super.key,required this.id,required this.title,required this.content});
  State<Editnotepage> createState()=> _editnoteState();
}

class _editnoteState extends State<Editnotepage>{

  late  TextEditingController titleContoller=TextEditingController();
  late  TextEditingController contentContoller=TextEditingController();
  late AppwriteService _appwriteService;

@override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    titleContoller = TextEditingController(text: widget.title);
    contentContoller = TextEditingController(text: widget.content);
  }

  Future<void> _updateNote() async {
    final title = titleContoller.text.trim();
    final content = contentContoller.text.trim();
    try {
      await _appwriteService.updateNote(widget.id, title, content);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Notepage(id: widget.id, title: title, content: content)));
    } catch (e) {
      print("Error updating note: $e");
    }
  }



  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        title: Text("Edit note",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          IconButton(onPressed: (){
            _updateNote();
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