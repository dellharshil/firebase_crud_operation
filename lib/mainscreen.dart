import 'package:firebasedemo/screen/email/loginpage.dart';
import 'package:firebasedemo/screen/email/signuppage.dart';
import 'package:firebasedemo/screen/phone/signupphone.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Main screen"),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Signupphone(),));
            }, child: Text("phone auth")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Loginpage(),));
            }, child: Text("emial auth")),
          ],
        ),
      ),
    );
  }
}
