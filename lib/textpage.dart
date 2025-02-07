import 'package:echo_note/textinputpage.dart';
import 'package:flutter/material.dart';

class Textpage extends StatelessWidget{
  const Textpage({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        title: Text("title",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Textinputpage()));
          }, icon: Icon(Icons.edit,color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.white,)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("wvqwvbqwergqerbqebrqergqwerfqegqwerfqe",style: TextStyle(fontSize: 20),),
      ),
    );
  }
}