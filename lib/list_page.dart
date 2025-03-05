import 'package:echo_note/appwrite.dart';
import 'package:echo_note/edit_listpage.dart';
import 'package:echo_note/homepage.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget{

  final String id;
  final String title;
  final List<String> items;
  const ListPage({super.key,required this.id,required this.title,required this.items});
  State<ListPage> createState()=> _listpageState();
}
class _listpageState extends State<ListPage>{
  late List<bool> selectedItems;

  late AppwriteService _appwriteService=AppwriteService();

  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    selectedItems = List.filled(widget.items.length, false); // Initialize selection list
  }


  Future<void> _deleteListDetatils(String listId)async{
    try{
      await _appwriteService.deleteList(listId);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }catch(e){
      print("error deleting list:$e");
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Editlistpage(id: widget.id, title:widget.title, items:widget.items)));
          }, icon: Icon(Icons.edit,color: Colors.white,)),
          IconButton(onPressed: (){
            _deleteListDetatils(widget.id);
          }, icon: Icon(Icons.delete,color: Colors.white,)),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: selectedItems[index],
              onChanged: (bool? value) {
                setState(() {
                  selectedItems[index] = value ?? false;
                });
              },
            ),
            title: Text(widget.items[index], style: const TextStyle(fontSize: 20)),
          );
        },
      ),
    );
  }
}