import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toast/toast.dart';
import 'readingpage.dart';
class ShowNotes extends StatefulWidget{


  @override
  State<ShowNotes> createState() => _ShowNotesState();
}

 final databaseref = FirebaseDatabase.instance.ref("Notes");
 final List<Color>  colorlist = [
   Colors.greenAccent,
   Colors.orangeAccent,
   Colors.yellow,
   Colors.lightBlueAccent,
 ];

class _ShowNotesState extends State<ShowNotes> {
  @override
  Widget build(BuildContext context){
    ToastContext().init(context);
    return Expanded(
      child: StreamBuilder( //stream builder
          stream: databaseref.onValue, //pass reference
          builder: (context, AsyncSnapshot<DatabaseEvent>snapshot) {

            //checking if snapshot is null
            if ( snapshot.hasData && !snapshot.hasError ) {

              // storing all data into a list
              Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic ;
              List<dynamic> list = [];
              list.clear();
              list = map.values.toList();

           // staggered grid view
            return MasonryGridView.count(
              mainAxisSpacing: 15,
            crossAxisSpacing: 12,
            itemCount: snapshot.data!.snapshot.children.length,
            crossAxisCount: 2,

            itemBuilder:  (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    ReadingPage(title: list[index]['title'].toString(),
                        message: list[index]['message'].toString(),
                        date: list[index]['Date'],
                         time: list[index]['time'],
                        id: list[index]['id'].toString(),
 
                        color: colorlist[index % colorlist.length])));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorlist[index % colorlist.length],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(list[index]['title'],style: TextStyle(color: Colors.black,
                        fontSize: 17, fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10,),
                        Text(list[index]['message'],style: TextStyle(color: Colors.black54,
                          fontSize: 15, fontWeight: FontWeight.bold,
                        ),
                        maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //delte icon
                        SizedBox(height: 25,),
                      //for date and time
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            //delete button

                            InkWell(
                                onTap: (){
                                  //delete notes
                                databaseref.child(list[index]['id'].toString()).remove().then((value){
                                  //on sucess
                                  Toast.show("Note Deleted!!", duration: Toast.lengthLong, gravity:  Toast.bottom);
                                }).onError((error, stackTrace) {
                                  // on error
                                  Toast.show(error.toString(), duration: Toast.lengthLong, gravity:  Toast.bottom);
                                });
                                },
                                child: Icon((Icons.delete),color: Colors.black38,)),

                            //date and time
                            Spacer(),
                            Column(
                              children: [
                                Text(list[index]['time'].toString(),style: TextStyle(color: Colors.black54,
                                  fontSize: 12, fontWeight: FontWeight.bold,
                                ),),
                                SizedBox(height: 5,),
                                Text(list[index]['Date'].toString(),style: TextStyle(color: Colors.black54,
                                  fontSize: 12, fontWeight: FontWeight.bold,
                                ),),
                                SizedBox(height: 10,),
                              ],
                            )
                          ],
                        ),
                      )
                      ],
                    ),
                  ),
                ),
              ),
            );
            },);
            }
            else{
            return Center(child: CircularProgressIndicator());
            }
          },
      ),
    );
  }
}