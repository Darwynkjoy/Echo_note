import 'dart:math';

import 'package:echo_note/textpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState()=> _homepageState();
}
class _homepageState extends State<HomePage>{

static Color randomColor(){
    List<Color> colors=[
      Color.fromRGBO(198, 245, 205, 1),
      Color.fromRGBO(148, 211, 247, 1),
      Color.fromRGBO(243, 174, 150, 1),
      Color.fromRGBO(203, 224, 171, 1),
      Color.fromRGBO(145, 201, 196, 1),
      Color.fromRGBO(239, 135, 170, 1),
      Color.fromRGBO(186, 252, 235, 1),
    ];
    return colors[Random().nextInt(colors.length)];
  }


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
        listScreen(),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10, 
              childAspectRatio: 2,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Textpage()));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: randomColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Title",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                          Icon(Icons.more_vert,color: Colors.black,)
                        ],
                      ),
                
                      Text("aefbwerwegitcitotxiyrtxiyrxiyrxirfxiyrxiyfrx",overflow: TextOverflow.ellipsis,maxLines: 3,)
                    ],
                  )
                ),
              );
            }
      ),
    );
  
  }
  Widget listScreen(){
     return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10, 
              childAspectRatio: 2,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: randomColor(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Title",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                        Icon(Icons.more_vert,color: Colors.black,)
                      ],
                    ),

                    Text("aefbwerwegitcitotxiyrtxiyrxiyrxirfxiyrxiyfrx",overflow: TextOverflow.ellipsis,maxLines: 3,)
                  ],
                )
              );
            }
      ),
    );
  }
}