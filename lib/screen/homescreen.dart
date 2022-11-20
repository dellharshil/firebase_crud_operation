import 'package:firebasedemo/screen/add_student.dart';
import 'package:firebasedemo/screen/list_student.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent(),));
          }, icon: Icon(Icons.add)),
        ],
      ),
      body: ListStudent(),
    );
  }
}
