
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Signuppage extends StatelessWidget {
  Signuppage({Key? key}) : super(key: key);
  TextEditingController emailcon=TextEditingController();
  TextEditingController passcon=TextEditingController();
  TextEditingController cpasscon=TextEditingController();


  @override
  Widget build(BuildContext context) {
    void createaccount() async{
      String email=emailcon.text.trim();
      String pass=passcon.text.trim();
      String cpass=cpasscon.text.trim();
      if(email=="" ||pass==""||cpass==""){
        print("Please enter field");
      }
      else if(pass!=cpass){
        print("enter same password");
      }
      else{
        try{
          UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
          print("Created");
          if(userCredential.user!=null){
            Navigator.pop(context);
          }
        } on FirebaseAuthException catch(ex){
          if(ex.code=="weak-password"){
            //snakbar
          }
          print(ex.code.toString());
        }

      }
    }
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text("SIGNUP PAGE"),),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: emailcon,
                  decoration: InputDecoration(labelText: "enter email",prefix: Icon(Icons.email)),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  controller: passcon,
                  decoration: InputDecoration(labelText: "enter password",prefix: Icon(Icons.email)),
                ),SizedBox(height: 10.0,),
                TextField(
                  controller: cpasscon,
                  decoration: InputDecoration(labelText: "re-enter password",prefix: Icon(Icons.email)),
                ),SizedBox(height: 10.0,),
                ElevatedButton(onPressed: createaccount, child: Text("CREATE")),
              ],
            ),
          ),
        );
      }
    );
  }
}
