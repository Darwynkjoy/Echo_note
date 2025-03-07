import 'package:echo_note/add_listpage.dart';
import 'package:echo_note/add_taskpage.dart';
import 'package:echo_note/appwrite.dart';
import 'package:echo_note/data.dart';
import 'package:echo_note/edit_listpage.dart';
import 'package:echo_note/edit_taskpage.dart';
import 'package:echo_note/edittextpage.dart';
import 'package:echo_note/addtextpage.dart';
import 'package:echo_note/list_page.dart';
import 'package:echo_note/textpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState()=> _homepageState();
}
class _homepageState extends State<HomePage>{

  late AppwriteService _appwriteService;
  late List<textsData> _texts;
  late List<tasksData> _tasks;
  late List<listsData> _lists;



  @override
  void initState(){
    super.initState();
    _appwriteService=AppwriteService();
    _texts=[];
    _tasks=[];
    _lists=[];
    _loadTextDetails();
    _loadTaskDetails();
    _loadListDetails();
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

  //List
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


  Future<void> _deleteListDetails(String listId)async{
    try{
      await _appwriteService.deleteList(listId);
      _loadListDetails();
    }catch(e){
      print("error deleting list:$e");
    }
  }

  @override
  Widget build(BuildContext context){
    return DefaultTabController(length: 3, child: Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "Echo",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold, color: Colors.white,),
            children: <TextSpan>[
              TextSpan(
                text: " Note",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
        centerTitle: false,
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
        ListScreen(),
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Addlistpage()));
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
              childAspectRatio: .9
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
                    color: const Color.fromARGB(69, 8, 179, 17),
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
                
                      Text("${text.content}",style: TextStyle(fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 6,)
                    ],
                  )
                ),
              );
            }
      ),
    );
  
  }

  //List screen
  Widget ListScreen(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: .9,
            ),
            itemCount: _lists.length,
            itemBuilder: (context, index) {
              final itemList=_lists[index];
              final itemsLength=itemList.items;
              return GestureDetector(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ListPage(id: itemList.listid, title: itemList.title, items: itemList.items)));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(92, 0, 140, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${itemList.title}",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                          //popupmenu for edit and delete
                          PopupMenuButton(
                            onSelected: (value){
                              if(value == 'Edit'){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Editlistpage(id: itemList.listid, title: itemList.title, items: itemList.items)));
                              }else{
                                _deleteListDetails(itemList.listid);
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
                      Expanded(
                        child: ListView.builder(
                          //physics: const NeverScrollableScrollPhysics(),
                          itemCount: itemsLength.length,
                          itemBuilder: (context,index){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${itemList.items[index]}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                            ],
                          );
                        }),
                      ),
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

              // Convert time string to TimeOfDay
              List<String> timeParts = task.time.split(":");
              TimeOfDay time = TimeOfDay(
              hour: int.parse(timeParts[0]),
              minute: int.parse(timeParts[1]),
              );
              
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:  Color.fromRGBO(255, 0, 0, 0.39),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text("${task.title}",style: TextStyle(fontSize: 19,color: Colors.black,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
                    Text("${task.date}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    Text("${time.format(context)}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child: Text("${task.description}",style: TextStyle(fontSize: 16,),overflow: TextOverflow.ellipsis,maxLines: 4,)),
                        PopupMenuButton(
                        onSelected: (value){
                          if(value == 'Edit'){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTaskpage(taskid: task.taskid, title: task.title, description: task.description, date: task.date, time: time)));
                          }else{
                            _deleteTaskDetails(task.taskid);
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