import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasedemo/mainscreen.dart';
import 'package:firebasedemo/screen/email/loginpage.dart';
import 'package:firebasedemo/screen/email/signuppage.dart';
import 'package:firebasedemo/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 TextEditingController namecon=TextEditingController();
 TextEditingController surcon=TextEditingController();
 TextEditingController agecon=TextEditingController();
 File? profilepic;
  @override
  Widget build(BuildContext context) {
    void logout() async{
     await FirebaseAuth.instance.signOut();
     Navigator.popUntil(context, (route) => route.isFirst);
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Mainscreen(),));
    }
    final firestore=FirebaseFirestore.instance.collection("users").snapshots();
    Future<void> save() async {
      String name=namecon.text.toString();
      String surname=surcon.text.toString();
      int age=int.parse(agecon.text.toString());

      namecon.clear();
      surcon.clear();
      agecon.clear();
      if(name!=null && surname!=null ){

        TaskSnapshot uploadTask=await FirebaseStorage.instance.ref().child("profilepicture").
        child(Uuid().v1()).putFile(profilepic!) ;

       TaskSnapshot taskSnapshot= await uploadTask;
       String downloadurl=await taskSnapshot.ref.getDownloadURL();

        Map<String,dynamic> detaisl={
          "name":name,
          "surname":surname,
          "age":age,
          "profilepic":downloadurl,
        };
        await FirebaseFirestore.instance.collection("users").add(detaisl);
        print("added");
      }
      else{
        print("please enter field");
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text("Home"),
      actions: [
        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        }, icon:Icon(Icons.add)),
        IconButton(onPressed: logout, icon: Icon(Icons.logout)),
      ],
      ),
      body: Padding(
            padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async{
                    XFile? selectedimage = await ImagePicker().pickImage(source: ImageSource.gallery);

                    if(selectedimage!=null){
                      File converted=File(selectedimage.path);
                      setState(() {
                        profilepic=converted;
                      });

                      print("selected");
                    }
                    else{
                      print("no selected");
                    }

                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.red,
                      backgroundImage:(profilepic!=null) ? FileImage(profilepic!): null,
                    ),
                  ),
                  TextField(
                    controller: namecon,
                    decoration: InputDecoration(
                      labelText: "enter name",

                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: surcon,
                    decoration: InputDecoration(labelText: "enter surname"),
                  ),
                  TextField(
                    controller: agecon,
                    decoration: InputDecoration(labelText: "enter age"),
                  ),
                  SizedBox(height: 10.0,),
                  ElevatedButton(onPressed: save, child: Text("Save")),
                  SizedBox(height: 20,),
                 StreamBuilder<QuerySnapshot>(
                   stream: firestore,
                     builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.connectionState==ConnectionState.active){
                        if(snapshot.hasData && snapshot.data!=null){
                          return Expanded(
                            flex: 1,
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                                itemBuilder:(context, index) {
                                Map<String,dynamic> usermap=snapshot.data!.docs[index].data() as Map<String,dynamic> ;
                                    return ListTile(
                                       leading: CircleAvatar(
                                        backgroundImage: NetworkImage(usermap["profilepic"].toString()),),
                                      title: Text(snapshot.data!.docs[index]["name"].toString() +"("+ usermap["age"].toString()+")",style: DefaultTextStyle.of(context).style,),
                                      subtitle: Text(usermap["surname"].toString()),
                                );
                                },),
                          );
                        }
                        else{
                          return Text("no data");
                        }
                      }
                      else {
                        return Center(child: CircularProgressIndicator());
                      }},),
                ],
              ),

        ),

      
    );
  }
}
