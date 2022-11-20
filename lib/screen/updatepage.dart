import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  final String id;
  const UpdatePage({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  Future<void> updateuser(id,name,email,password) async {
        return FirebaseFirestore.instance.collection('student').doc(widget.id)
            .update({'name':name,'email':email,'password':password})
            .then((value) => debugPrint('Updated'))
            .catchError((onError)=>debugPrint('error updated $onError'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UPDATE DETAILS"),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
            future: FirebaseFirestore.instance.collection('student').doc(widget.id).get(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                print("loading error");
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              var data1=snapshot.data!.data();
              var name=data1!["name"];
              var email=data1["email"];
              var pass=data1["password"];
              return Padding(
                padding: const EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      onChanged:(value) {
                        name=value;
                      },
                      initialValue: name,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Name:",
                        labelStyle: TextStyle(fontSize: 20.0),
                        border:OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                      ),
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
                      onChanged:(value) {
                        email=value;
                      },
                      initialValue: email,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Email:",
                        labelStyle: TextStyle(fontSize: 20.0),
                        border:OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                      ),

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
                      onChanged:(value) {
                        pass=value;
                      },
                      initialValue: pass,
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password:",
                        labelStyle: TextStyle(fontSize: 20.0),
                        border:OutlineInputBorder(borderSide: BorderSide(width: 10.0)),
                        errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                      ),

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
                          ElevatedButton(onPressed: (){
                            updateuser(widget.id,name,email,pass);
                            Navigator.pop(context);
                          }, child:
                          Text("Update",style: TextStyle(fontSize: 18.0),),
                          ),
                          ElevatedButton(onPressed: (){

                          }, child:
                          Text("Reset",style: TextStyle(fontSize: 18.0),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },

          ),
        ),
      ),
    );
  }
}
