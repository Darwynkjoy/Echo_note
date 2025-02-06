import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState()=> _homepageState();
}
class _homepageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return DefaultTabController(length: 3, child: Scaffold(
      appBar: AppBar(
        title: Text("Echo Notes",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        bottom: TabBar(
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.black,//unselected tab color
          labelColor: Colors.white,// selected tab color
          tabs: [
            Text("Text",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),selectionColor: Colors.amber,),
            Text("List",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Text("Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ]),
      ),

      body: TabBarView(children: [
        textScreen(),
        Text("List"),
        Text("task")
      ]),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        onPressed: (){},
      child: Icon(Icons.add,color: Colors.black,size: 30,)),

    ),
    );
  }
  //text screen 
  Widget textScreen(){
    return GridView.custom(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount), childrenDelegate: SliverChildBuilderDelegate(builder))
  }
}