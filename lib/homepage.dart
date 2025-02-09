import 'dart:math';
import 'package:echo_note/appwrite.dart';
import 'package:echo_note/editnotepage.dart';
import 'package:echo_note/note_data.dart';
import 'package:echo_note/addnotepage.dart';
import 'package:echo_note/notepage.dart';
import 'package:flutter/material.dart';

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
    ];
    return colors[Random().nextInt(colors.length)];
  }
  late AppwriteService _appwriteService;
  late List<notesData> _notes;

  @override
  void initState(){
    super.initState();
    _appwriteService=AppwriteService();
    _notes=[];
    _loadNotesDetails();
  }

  Future <void> _loadNotesDetails()async{
    try{
      final task=await _appwriteService.getNoteDetails();
      setState(() {
        _notes=task.map((e)=> notesData.fromDocument(e)).toList();
      });
    }catch(e){
      print("error loading task: $e");
    }
  }


  Future<void> _deleteNoteDetatils(String taskId)async{
    try{
      await _appwriteService.deleteNote(taskId);
      _loadNotesDetails();
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
            Text("Notes",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),selectionColor: Colors.amber,),
            Text("List",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Text("Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ]),
      ),

      body: TabBarView(children: [
        noteScreen(),
        listScreen(),
        Text("task")
      ]),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotepage()));
        },
      child: Icon(Icons.add,color: Colors.black,size: 30,)),

    ),
    );
  }

  //note screen 
   Widget noteScreen(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10, 
              childAspectRatio: 2,
            ),
            itemCount: _notes.length,
            itemBuilder: (context, index) {
              final note=_notes[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Notepage(id: note.id, title: note.title, content: note.content)));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: randomColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${note.title}",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                          //popupmenu for edit and delete
                          PopupMenuButton(
                            onSelected: (value){
                              if(value == 'edit'){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Editnotepage(id: note.id, title: note.title, content: note.content)));
                              }else{
                                _deleteNoteDetatils(note.id);
                              }
                            },
                            itemBuilder: (BuildContext context){
                              return {'edit','delete'}.map((String choice){
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

                      Text("${note.content}",overflow: TextOverflow.ellipsis,maxLines: 3,)
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