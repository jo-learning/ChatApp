import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  // AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool circularprograss = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _groupcontroller = TextEditingController();
  String? email;
  String? group;
  User? loginuser;

void getcurrentuser()async{
    try{
    final user = await _auth.currentUser;
    if (user != null){
      loginuser = user;
      print(loginuser!.email);
    }
    }catch(e){
      print(e);
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                //TODO here the brand image icon
                height: 250,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailcontroller,
                      onChanged: (value){
                        email = value;
                      },
                decoration: const InputDecoration(
                  labelText: "Enter Email address",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  )
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _groupcontroller,
                onChanged: (value){
                  group = value;
                },
                decoration: const InputDecoration(
                  labelText: "Enter the group",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  )
                ),
                
              ),
      
              // TODO Capcha.....
              
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: 300,
                height: 60,
                child: ElevatedButton(onPressed: () async{
                  if(email != null && group != null) {
                    try{
                      circularprograss = true;
                      await _firestore.collection('channel').add({
                        'email': email,
                        'group': group
                      });
                        _emailcontroller.clear();
                        _groupcontroller.clear();
                        circularprograss = false;
                    }catch(e){
                      //TODO handle the error
                      print(e);
                      print("didn't signup");
                      circularprograss = false;
                    }

                  }
                }, child: circularprograss == false ? const Text("add group") : CircularProgressIndicator())),
                
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}