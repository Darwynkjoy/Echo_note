import 'package:echo_note/appwrite.dart';
import 'package:echo_note/data.dart';
import 'package:echo_note/list_page.dart';
import 'package:flutter/material.dart';

class Editlistpage extends StatefulWidget{

  final String id;
  final String title;
  final List<String> items;
  const Editlistpage({super.key,required this.id,required this.title,required this.items});
  State<Editlistpage> createState()=> _editlistState();
}

class _editlistState extends State<Editlistpage>{

    late TextEditingController titleContoller=TextEditingController();
    late TextEditingController itemsController=TextEditingController();
    List <String> itemList=[];

    late AppwriteService _appwriteService;
    late List<listsData> _lists;

  @override
  void initState(){
    super.initState;
    _appwriteService=AppwriteService();
    titleContoller=TextEditingController(text: widget.title);
    itemList=widget.items;
    _lists=[];
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

  Future<void> _updateList() async {
    final title = titleContoller.text.trim();
    final items=itemList;
    if(title.isEmpty || items.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title and items should not be empty"),backgroundColor: Colors.red,));
    }else{
    try {
      await _appwriteService.updateList(widget.id, title, items);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ListPage(id: widget.id, title: title, items: items)));
    } catch (e) {
      print("Error updating items: $e");
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
            _updateList();
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
              controller: itemsController,
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
                  onTap: (){
                    if(itemsController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title and items should not be empty"),backgroundColor: Colors.red,));
                    }else{
                    setState(() {
                      itemList.add(itemsController.text);
                      itemsController.clear();
                    });
                    }
                  },
                  child: Icon(Icons.add,color:  const Color.fromARGB(255, 8, 179, 16),))
                ),
                textAlignVertical: TextAlignVertical.top,
                
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context,index){
                return ListTile(
                  leading: Text("${itemList[index]}",style: TextStyle(fontSize: 20,color: Colors.black),),
                  trailing: IconButton(onPressed: (){
                    setState(() {
                        widget.items.removeAt(index);
                    });
                  },
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