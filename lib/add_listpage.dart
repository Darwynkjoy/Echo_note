import 'package:echo_note/appwrite.dart';
import 'package:echo_note/data.dart';
import 'package:echo_note/homepage.dart';
import 'package:flutter/material.dart';

class Addlistpage extends StatefulWidget{
  @override
  State<Addlistpage> createState()=> _addlistState();
}

class _addlistState extends State<Addlistpage>{

    TextEditingController titleContoller=TextEditingController();
    TextEditingController itemsContoller=TextEditingController();

    late AppwriteService _appwriteService;
    late List<listsData> _lists;

  @override
  void initState(){
    super.initState;
    _appwriteService=AppwriteService();
    _lists=[];
    _loadListDetails();
  }

    Future <void> _loadListDetails()async{
    try{
      final listBox=await _appwriteService.getListDetails();
      setState(() {
        _lists=listBox.map((e)=> listsData.fromDocument(e)).toList();
      });
    }catch(e){
      print("error loading list: $e");
    }
  }

  Future<void>_addList()async{
    final title=titleContoller.text;
    final items=itemsContoller.text;
    if(title.isEmpty || items.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title and items should not be empty"),backgroundColor: Colors.red,));
    }else{
    try{
      //await _appwriteService.addList(title,List<String> items);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }catch(e){
        print("error adding list:$e");
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
            _addList();
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
            TextField(
              controller: itemsContoller,
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
                labelText: "Items",
                labelStyle: TextStyle(color: const Color.fromARGB(255, 8, 179, 16),),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                alignLabelWithHint: true,
                suffixIcon: GestureDetector(
                  onTap: (){},
                  child: Icon(Icons.add,color:  const Color.fromARGB(255, 8, 179, 16),))
                ),
                textAlignVertical: TextAlignVertical.top,
                
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context,index){
                return ListTile(
                  leading: Text("data",style: TextStyle(fontSize: 20,color: Colors.black),),
                  trailing: IconButton(onPressed: (){},
                  icon: Icon(Icons.close)),
                );
              }),
            )
          ],
        ),
      )
    );
  }
}