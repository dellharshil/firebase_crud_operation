import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/screen/email/homepage.dart';
import 'package:flutter/material.dart';

class Varify extends StatelessWidget {
  final String verificationId;
   Varify({Key? key,required this.verificationId}) : super(key: key);
TextEditingController otpcon=TextEditingController();
  @override
  Widget build(BuildContext context) {
    void otpverify()async{
        String otp=otpcon.text.trim();
        PhoneAuthCredential credential=await PhoneAuthProvider.credential
          (verificationId: verificationId, smsCode: otp);
        try{
    UserCredential userCredential=
    await FirebaseAuth.instance.signInWithCredential(credential);
    if(userCredential!=null){
      Navigator.popUntil(context, (route) => route.isFirst);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(),));
    }
        } on FirebaseAuthException catch(ex){
          print(ex.code.toString());
        }
    }
    return Scaffold(
      appBar: AppBar(title: Text("Verify "),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(controller:otpcon,maxLength:6,decoration: InputDecoration(labelText: "enter 6-digti otp"),),
            SizedBox(height: 10.0,),
            ElevatedButton(onPressed: otpverify, child: Text("Verify")),
          ],
        ),
      ),
    );
  }
}
