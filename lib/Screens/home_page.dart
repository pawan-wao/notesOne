import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesone/Screens/addnotepage.dart';
import 'package:notesone/Screens/shownotes.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 5,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddNote(),));
          },
        ),
        body: SafeArea(
          // top level column
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //top level row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //profile picture
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/businesswoman-posing_23-2148142829.jpg?w=360&t=st=1703848209~exp=1703848809~hmac=c8604d8f4a5554baa31cacb3003adaa510059b65a5ae0aa033ea7ac48bf61e6b",
                      ),

                    ),

                    //app tittle
                   Row(
                     children: [
                       Text("Notes",style: TextStyle(fontWeight: FontWeight.bold,
                         fontSize: 25,
                       ),),
                       // app tittle
                       Text("One",style: TextStyle(fontWeight: FontWeight.bold,
                         fontSize: 25, color: Colors.deepOrange,
                       ),),
                     ],
                   ),

                    //app drawer
                    Icon(Icons.menu_rounded),

                  ],
                ),
                SizedBox(height: 15,),
                Text("My Notes",style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 35,
                ), ),
                SizedBox(height: 20,),
                ShowNotes(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}