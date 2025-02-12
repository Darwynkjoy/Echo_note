import 'package:echo_note/appwrite.dart';
import 'package:echo_note/data.dart';
import 'package:echo_note/homepage.dart';
import 'package:flutter/material.dart';

class Addtextpage extends StatefulWidget{
  @override
  State<Addtextpage> createState()=> _addtextState();
}

class _addtextState extends State<Addtextpage>{

    TextEditingController titleContoller=TextEditingController();
    TextEditingController contentContoller=TextEditingController();

    late AppwriteService _appwriteService;
    late List<textsData> _texts;

  @override
  void initState(){
    super.initState;
    _appwriteService=AppwriteService();
    _texts=[];
    _loadTextDetails();
  }

    Future <void> _loadTextDetails()async{
    try{
      final task=await _appwriteService.getTextDetails();
      setState(() {
        _texts=task.map((e)=> textsData.fromDocument(e)).toList();
      });
    }catch(e){
      print("error loading task: $e");
    }
  }

    Future<void>_addText()async{
    final title=titleContoller.text;
    final content=contentContoller.text;
    if(title.isEmpty || content.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title and content should not be empty"),backgroundColor: Colors.red,));
    }else{
    try{
      await _appwriteService.addText(title,content);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }catch(e){
        print("error adding text:$e");
    }
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        title: Text("Add New Text",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          IconButton(onPressed: (){
            _addText();
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