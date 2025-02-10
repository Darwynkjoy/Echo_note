import 'package:echo_note/appwrite.dart';
import 'package:echo_note/notepage.dart';
import 'package:flutter/material.dart';

class Edittextpage extends StatefulWidget{
  @override
  final String id;
  final String title;
  final String content;
  const Edittextpage({super.key,required this.id,required this.title,required this.content});
  State<Edittextpage> createState()=> _edittextState();
}

class _edittextState extends State<Edittextpage>{

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

  Future<void> _updateText() async {
    final title = titleContoller.text.trim();
    final content = contentContoller.text.trim();

    if(title.isEmpty || content.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title and content should not be empty"),backgroundColor: Colors.red,));
    }else{
    try {
      await _appwriteService.updateText(widget.id, title, content);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Textpage(id: widget.id, title: title, content: content)));
    } catch (e) {
      print("Error updating note: $e");
    }
    }
  }



  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        title: Text("Edit Text",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          IconButton(onPressed: (){
            _updateText();
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