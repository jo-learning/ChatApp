import 'package:chatapp/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'channelpage.dart';

class Registration extends StatefulWidget {
  // Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _passwordchecker = TextEditingController();
  String? email;
  String? password;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // await Firebase.initializeApp().whenComplete(() {
    //   print("completed");
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    //TODO Spinner waiting for the registration
    return  Scaffold(
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
                  labelText: "Enter your Email",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  )
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //TODO if password is not equal with the checker change the border color
              TextField(
                controller: _passwordcontroller,
                onChanged: (value){
                  if(_passwordcontroller.text == _passwordchecker.text){
                    password = _passwordcontroller.text;
                  }
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Enter your Password",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
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
                controller: _passwordchecker,
                onChanged: (value){
                  if(_passwordcontroller.text == _passwordchecker.text){
                    password = _passwordcontroller.text;
                  }
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Rewrite your Password",
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
                margin: const EdgeInsets.only(top: 10),
                width: 300,
                height: 60,
                child: ElevatedButton(onPressed: () async{
                  print('${email}  ${password}');
                  if(email != null && password != null) {
                    try{
                      await _auth.createUserWithEmailAndPassword(
                          email: email!, password: password!);
                          _firestore.collection('channel').add({
                            'email': email,
                            'group': 'firstgroup'
                          });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Channel()));

                    }catch(e){
                      //TODO error handling
                      print(e);
                    }

                  }
                }, child: const Text("Register"))),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 300,
                height: 60,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                }, child: const Text("Back to Login")))
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