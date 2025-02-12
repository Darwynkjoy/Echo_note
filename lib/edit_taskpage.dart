import 'package:echo_note/appwrite.dart';
import 'package:echo_note/homepage.dart';
import 'package:flutter/material.dart';

class EditTaskpage extends StatefulWidget{
  @override
  final String taskid;
  final String title;
  final String description;
  final String date;
  final String time;
  const EditTaskpage({super.key,required this.taskid,required this.title,required this.description,required this.date,required this.time});
  State<EditTaskpage> createState()=> _edittaskState();
}

class _edittaskState extends State<EditTaskpage>{

    late TextEditingController titleContoller=TextEditingController();
    late TextEditingController descriptionController=TextEditingController();
    late AppwriteService _appwriteService;
    
     DateTime selectedDate=DateTime.now();
     TimeOfDay selectedtime=TimeOfDay.now();


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
    titleContoller=TextEditingController(text: widget.title);
    descriptionController=TextEditingController(text: widget.description);
  }

    Future<void> _updateTask() async {
    final title = titleContoller.text.trim();
    final description = descriptionController.text.trim();
    final date="${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    final time="${selectedtime.hour}:${selectedtime.minute}";

    if(title.isEmpty || description.isEmpty ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title and description should not be empty"),backgroundColor: Colors.red,));
    }else{
    try {
     await _appwriteService.updateTask(widget.taskid, title, description, date, time);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    } catch (e) {
      print("Error updating note: $e");
    }
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 179, 16),
        title: Text("Edit Task",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          IconButton(onPressed: (){
            _updateTask();
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
                child: Text(selectedDate != null? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 8, 179, 16),),),)
              ],
            )
          ],
        ),
      )
    );
  }
}