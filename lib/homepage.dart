import 'dart:math';
import 'package:echo_note/add_taskpage.dart';
import 'package:echo_note/appwrite.dart';
import 'package:echo_note/data.dart';
import 'package:echo_note/edittextpage.dart';
import 'package:echo_note/addtextpage.dart';
import 'package:echo_note/textpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState()=> _homepageState();
}
class _homepageState extends State<HomePage>{

  TextEditingController titleContoller=TextEditingController();
  TextEditingController contentContoller=TextEditingController();

static Color randomColor(){
    List<Color> colors=[
      Color.fromRGBO(198, 245, 205, 1),
      Color.fromRGBO(148, 211, 247, 1),
      Color.fromRGBO(243, 174, 150, 1),
      Color.fromRGBO(203, 224, 171, 1),
      Color.fromRGBO(145, 201, 196, 1),
      Color.fromRGBO(239, 135, 170, 1),
      Color.fromRGBO(186, 252, 235, 1),
      Color.fromARGB(255, 183, 139, 212),
      Color.fromRGBO(253, 99, 99, 1),
    ];
    return colors[Random().nextInt(colors.length)];
  }
  late AppwriteService _appwriteService;
  late List<textsData> _texts;
  late List<tasksData> _tasks;

  @override
  void initState(){
    super.initState();
    _appwriteService=AppwriteService();
    _texts=[];
    _tasks=[];
    _loadTextDetails();
    _loadTaskDetails();
  }

  Future <void> _loadTextDetails()async{
    try{
      final textBox=await _appwriteService.getTextDetails();
      setState(() {
        _texts=textBox.map((e)=> textsData.fromDocument(e)).toList();
      });
    }catch(e){
      print("error loading text: $e");
    }
  }


  Future<void> _deleteTextDetails(String textId)async{
    try{
      await _appwriteService.deleteText(textId);
      _loadTextDetails();
    }catch(e){
      print("error deleting text:$e");
    }
  }

  //task 
  Future <void> _loadTaskDetails()async{
    try{
      final taskBox=await _appwriteService.getTaskDetails();
      setState(() {
        _tasks=taskBox.map((e)=> tasksData.fromDocument(e)).toList();
      });
    }catch(e){
      print("error loading task: $e");
    }
  }


  Future<void> _deleteTaskDetails(String taskId)async{
    try{
      await _appwriteService.deleteTask(taskId);
      _loadTaskDetails();
    }catch(e){
      print("error deleting task:$e");
    }
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
            Text("Texts",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),selectionColor: Colors.amber,),
            Text("List",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Text("Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ]),
      ),

      body: TabBarView(children: [
        TextScreen(),
        Text("list"),
        TaskScreen(),
      ]),

      floatingActionButton: SpeedDial(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        activeChild: Icon(Icons.close,color: Colors.black,),
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            shape: CircleBorder(),
            backgroundColor: const Color.fromARGB(255, 8, 179, 16),
            elevation: 5,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Addtextpage()));
            },
            child: Icon(Icons.text_snippet,color: Colors.black,),label: "Text",labelStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)
          ),
          SpeedDialChild(
            shape: CircleBorder(),
            backgroundColor: const Color.fromARGB(255, 8, 179, 16),
            elevation: 5,
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Addtaskpage()));
            },
            child: Icon(Icons.list,color: Colors.black,),label: "List",labelStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)
          ),
          SpeedDialChild(
            shape: CircleBorder(),
            backgroundColor: const Color.fromARGB(255, 8, 179, 16),
            elevation: 5,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Addtaskpage()));
            },
            child: Icon(Icons.task,color: Colors.black,),label: "Task",labelStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)
          )
        ],
      child: Icon(Icons.add,color: Colors.black,size: 30,)),
    ),
    );
  }

  //Text screen 
   Widget TextScreen(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.2
            ),
            itemCount: _texts.length,
            itemBuilder: (context, index) {
              final text=_texts[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Textpage(id: text.textid, title: text.title, content: text.content)));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: randomColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${text.title}",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                          //popupmenu for edit and delete
                          PopupMenuButton(
                            onSelected: (value){
                              if(value == 'Edit'){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Edittextpage(id: text.textid, title: text.title, content: text.content)));
                              }else{
                                _deleteTextDetails(text.textid);
                              }
                            },
                            itemBuilder: (BuildContext context){
                              return {'Edit','Delete'}.map((String choice){
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                  );
                              }).toList();
                            },
                            icon: Icon(Icons.more_vert),
                            ),
                        ],
                      ),
                
                      Text("${text.content}",style: TextStyle(fontSize: 16),overflow: TextOverflow.visible,)
                    ],
                  )
                ),
              );
            }
      ),
    );
  
  }

  //task screen
  Widget TaskScreen(){
     return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10, 
            ),
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              final task=_tasks[index];
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:  Color.fromRGBO(253, 99, 99, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${task.title}",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),

                    Text("06-07-25",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    Text("2:23",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    Spacer(),
                    Text("${task.description}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Spacer(),
                    Row(
                      children: [
                        Text("Task ended",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        Spacer(),
                        PopupMenuButton(
                            onSelected: (value){
                              if(value == 'Edit'){
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>Edittextpage(id: text.textid, title: text.title, content: text.content)));
                              }else{
                                _deleteTextDetails(task.taskid);
                              }
                            },
                            itemBuilder: (BuildContext context){
                              return {'Edit','Delete'}.map((String choice){
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                  );
                              }).toList();
                            },
                            icon: Icon(Icons.more_vert),
                            ),
                      ],
                    ),



                  ],
                )
              );
            }
      ),
    );
  }
}