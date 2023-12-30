import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:toast/toast.dart';
class EditNote extends StatefulWidget{
  String id;
  String title;
  String message;
  String date;
  String time;

  EditNote({required this.id, required this.title, required this.message, required this.date, required this.time});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  var titleController = TextEditingController();
  var messageController = TextEditingController();

  // to assign value of tittle to its controller
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    messageController = TextEditingController(text: widget.message);
  }
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("Notes");
  @override
  Widget build(BuildContext context){
    ToastContext().init(context);
    return  MaterialApp(
      darkTheme: ThemeData(
          brightness: Brightness.dark
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: SafeArea(
          // top level coloumn
       child: Padding(
         padding: const EdgeInsets.all(25.0),
         child: Column(
           children: [

             //title textfield
             TextFormField(
               controller: titleController,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10)),
                 label: Text("Tittle"),
               ),
             ),
             SizedBox(height: 20,),

             //notes body
             TextFormField(
               controller: messageController,
               maxLines: 10,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10)),
                 label: Text("Message"),

               ),
             ),
             SizedBox(height: 15,),

             // save button
             Container(
               alignment: Alignment.topRight,
               child: InkWell(
                 onTap: (){
                   setState(() {
                     loading = true;
                   });

                   String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
                   String time = DateFormat('hh:mm a').format(DateTime.now());

                   databaseRef.child(widget.id.toString()).set({
                     "title": titleController.text.toString().trim(),
                     "message": messageController.text.toString().trim(),
                     "Date": date.toString(),
                     "time": time.toString(),
                     "id": widget.id.toString(),
                   }).then((value) => {
                     //sucess code
                     setState(() {
                       loading= false;
                     }),
                   Toast.show("Note Updated!!", duration: Toast.lengthLong, gravity:  Toast.bottom),
                     Navigator.pop(context),
                   Navigator.pop(context),

                 });

                 },
                 child:
                 loading == false ?
                 Text("Update Now",style: TextStyle(fontSize: 25)):
                 Center(
                     child: Padding(
                       padding: const EdgeInsets.all(2),
                       child: CircularProgressIndicator(),
                     )),
               ),
             )
           ],
         ),
       ),
        ),
      ),
    );
  }
}