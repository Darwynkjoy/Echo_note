import 'package:echo_note/appwrite.dart';
import 'package:echo_note/data.dart';
import 'package:echo_note/homepage.dart';
import 'package:flutter/material.dart';

class EditTaskpage extends StatefulWidget{
  @override
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  const EditTaskpage({super.key,required this.id,required this.title,required this.description,required this.date,required this.time});
  State<EditTaskpage> createState()=> _edittaskState();
}

class _edittaskState extends State<EditTaskpage>{

    TextEditingController titleContoller=TextEditingController();
    TextEditingController descriptionController=TextEditingController();

     DateTime selectedDate=DateTime.now();
     TimeOfDay selectedtime=TimeOfDay.now();

    late AppwriteService _appwriteService;
    late List<tasksData> _tasks;

    Future <void> _selectedDate(BuildContext context)async{
      final DateTime? picked=await showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(1990), lastDate: DateTime(2100));
      if( picked != null && picked != selectedDate){
        setState(() {
          selectedDate=picked;
        });
      }
    }

    Future<void> _selectedTime(BuildContext context)async{
      final TimeOfDay? picked=
      await showTimePicker(context: context, initialTime: selectedtime);
      if(picked != null && picked != selectedtime){
        setState(() {
          selectedtime=picked;
        });
      }
    }

  @override
  void initState(){
    super.initState;
    _appwriteService=AppwriteService();
    _tasks=[];
    _loadTaskDetails();
  }

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

    Future<void>_addTask()async{
    final title=titleContoller.text;
    final description=descriptionController.text;
    final date="${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    final time="${selectedtime.hour}:${selectedtime.minute}";
    if(title.isEmpty || description.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title and Description should not be empty"),backgroundColor: Colors.red,));
    }else{
    try{
      await _appwriteService.addTask(title, description,date,time);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }catch(e){
        print("error adding task:$e");
    }
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        title: Text("Add New Task",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          IconButton(onPressed: (){
            _addTask();
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
            //description textfeild
            SizedBox(
              height: 590,
              width: double.infinity,
              child: TextField(
                controller: descriptionController,
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
                  labelText: "Description",
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 8, 179, 16),),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  alignLabelWithHint: true,
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: true,
                  
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  _selectedTime(context);
                },
                child: Text("${selectedtime.format(context)}",style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 8, 179, 16),),),),
                TextButton(onPressed: (){
                  _selectedDate(context);
                },
                child: Text(selectedDate != null? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 8, 179, 16),),),)
              ],
            )
          ],
        ),
      )
    );
  }
}