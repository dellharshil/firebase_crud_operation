
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final formkey=GlobalKey<FormState>();
  TextEditingController emailcon=TextEditingController();
  TextEditingController pass=TextEditingController();
  TextEditingController namecon=TextEditingController();
  void clear(){
    namecon.clear();
    emailcon.clear();
    pass.clear();
  }

  void register() async{
      String name=namecon.text.trim();
      String email=emailcon.text.trim();
      String password=pass.text.toString();
     clear();
      Map<String,dynamic> add1={
        'name':name,
        'email':email,
        'password':password
      };
      FirebaseFirestore.instance.collection('student').add(add1)
      .then((value) => debugPrint('user added'))
      .catchError((error)=>debugPrint('added erro $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ADD STUDENT"),),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: "Name:",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border:OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                  ),
                  controller:namecon,
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Please enter name";
                    }
                    else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Email:",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border:OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                  ),
                  controller:emailcon ,
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Please enter Email";
                    }else if(!value.contains("@")){
                      return "please enter valid email";
                    }
                    else{
                      return null;
                    }
                  },
                ),   SizedBox(height: 20.0,),
                TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password:",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border:OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                  ),
                  controller: pass,
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Please enter Password";
                    }
                    else{
                      return null;
                    }
                  },
                ),SizedBox(height: 20.0,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){register();}, child:
                      Text("register",style: TextStyle(fontSize: 18.0),),
                      ),
                      ElevatedButton(onPressed: (){clear();}, child:
                      Text("Reset",style: TextStyle(fontSize: 18.0),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
