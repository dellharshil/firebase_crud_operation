import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/screen/email/homepage.dart';
import 'package:firebasedemo/screen/email/loginpage.dart';
import 'package:firebasedemo/screen/phone/signupphone.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("users").get() as QuerySnapshot<Object?>;
  // for (var doc in querySnapshot.docs){
  //   print(doc.data().toString());
  // }

  //perticular item fetch
 // DocumentSnapshot documentSnapshot=await FirebaseFirestore.instance.collection("users").doc("k8C70OlYUOi5iRfZsypF").get();
 // print(documentSnapshot.data().toString());

  // Map<String,dynamic> usermap={
  //   "name":"harshil12",
  //   "surname":"ribadiya12"
  // };
  //add and update
// await FirebaseFirestore.instance.collection("users").add(usermap);
//   await FirebaseFirestore.instance.collection("users").doc("your-id").set(usermap);
//   await FirebaseFirestore.instance.collection("users").doc("your-id").update({
//     "name":"nirav"
//   });
//   await FirebaseFirestore.instance.doc("your-id").delete();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home:(FirebaseAuth.instance.currentUser!=null) ? Homepage() : Mainscreen(),
    );
  }
}
