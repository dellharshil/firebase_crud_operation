import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/screen/email/homepage.dart';
import 'package:firebasedemo/screen/email/signuppage.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  Loginpage({Key? key}) : super(key: key);
  TextEditingController emailcon=TextEditingController();
  TextEditingController passcon=TextEditingController();

  @override
  Widget build(BuildContext context) {
    void login() async{
      String email=emailcon.text.trim();
      String password=passcon.text.trim();
      if(email=="" || password==""){
            print("Enter feild");
      }
      else{
        try{
          UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
          if(userCredential!=null){
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(),));
          }
        } on FirebaseAuthException catch(ex){
          print(ex.code.toString());
          if(ex.code=="wrong-password"){
            SnackBar(content: Text("wrong password"),duration: Duration(seconds: 3),backgroundColor: Colors.red,);
          }
        }
      }
     

    }
    return Scaffold(
      appBar: AppBar(title: Text("LOGIN PAGE"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            ElevatedButton(onPressed: login, child: Text("LOGIN")),
            SizedBox(height: 15.0,),
            InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Signuppage(),)),child: Text("Create new Account")),
          ],
        ),
      ),
    );
  }
}



