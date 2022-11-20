import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/screen/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  State<ListStudent> createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {

  final firestore1=FirebaseFirestore.instance.collection("student").snapshots();

  Future<void> delateuser(id){
  //print('user id $id');
    return FirebaseFirestore.instance.collection('student').doc(id).delete()
        .then((value) => debugPrint('user delated'))
        .catchError((onError)=>debugPrint('error is $onError'));
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore1,
        builder:(context,AsyncSnapshot<QuerySnapshot> snapshot) {

          if(snapshot.hasError){
            print("Somthing went wrong") ;
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          final List store=[];
          snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
            Map<String,dynamic> a=documentSnapshot.data() as Map<String,dynamic> ;
            store.add(a);
            a['id']=documentSnapshot.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(),
                columnWidths: <int,TableColumnWidth>{
                  1:FixedColumnWidth(160),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                      children: [
                        TableCell(child:
                        Container(
                          color: Colors.greenAccent,
                          child: Center(child: Text("Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                        ),
                        ),
                        TableCell(child:
                        Container(
                          color: Colors.greenAccent,
                          child: Center(child: Text("Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                        ),
                        ),
                        TableCell(child:
                        Container(
                          color: Colors.greenAccent,
                          child: Center(child: Text("Action",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                        ),
                        ),
                      ]
                  ),
                  for(var i=0;i<store.length;i++)...[
                  TableRow(
                      children: [
                        TableCell(child:
                        Center(child: Text(store[i]["name"],style: TextStyle(fontSize: 18),),
                        ),),
                        TableCell(child:
                        Center(child: Text(store[i]["email"],style: TextStyle(fontSize: 18),),
                        ),),
                        TableCell(child:
                        Row(children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(id:store[i]['id']),));
                          }, icon: Icon(Icons.edit,color: Colors.orange,)),
                          IconButton(onPressed: (){
                              delateuser(store[i]['id']);
                          }, icon: Icon(Icons.delete,color: Colors.red,)),
                        ],)
                        ),
                      ]
                  ),
                ],
          ],
              ),
            ),
          );
        },
    );

  }
}
