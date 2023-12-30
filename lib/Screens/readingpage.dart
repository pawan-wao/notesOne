import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesone/Screens/editnote.dart';

class ReadingPage extends StatelessWidget{
  String id;
  String time;
  String date;
  String title;
  String message;
  Color color;

  ReadingPage({required this.title, required this.message,
  required this.color, required this.id, required this.date, required this.time,
  });

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: color,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditNote(id: id, title: title, message: message, date: date, time: time)));
          },
          backgroundColor: Colors.grey.shade400,
          child: Icon(CupertinoIcons.pen,color: Colors.black,),
        ),
        body: SafeArea(
          // top level coloumn
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25,bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: color,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(child: Icon(CupertinoIcons.back)),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                // title of note text
                Text(title.toString(),style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,

                ),),
                SizedBox(height: 15,),
                //message text
                Text(message.toString(),style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),),

                //time
                Spacer(),
                Text(time.toString(),style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),),

                //date
                Text(date.toString(),style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}