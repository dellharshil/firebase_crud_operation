import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/screen/phone/varify.dart';
import 'package:flutter/material.dart';

class Signupphone extends StatelessWidget {
   Signupphone({Key? key}) : super(key: key);
TextEditingController phonecon=TextEditingController();
  @override
  Widget build(BuildContext context) {

    void sendotp() async{
      String phone="+91" +phonecon.text.trim();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
          verificationCompleted: (credential){},
          verificationFailed: (error) {
            print(error.code.toString());
          },
          codeSent: (verificationId,resendToken){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Varify(verificationId: verificationId,),));
          },
          codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 30),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Signup"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: phonecon,
              decoration: InputDecoration(labelText: "Enter phone number",),
            ),SizedBox(height: 10.0,),
            ElevatedButton(onPressed: sendotp, child: Text("Signup"),),
          ],
        ),
      ),
    );
  }
}
