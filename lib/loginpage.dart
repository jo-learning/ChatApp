import 'package:chatapp/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/channelpage.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class Login extends StatefulWidget {
  // Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    //TODO spinner waiting for the login authentication
    return  ProgressHUD(
      child: Builder(
        builder:(context) => Scaffold(
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
                    obscureText: true,
                    controller: _passwordcontroller,
                    onChanged: (value){
                      password = value;
                    },
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
          
                  // TODO Capcha.....
                  
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: 300,
                    height: 60,
                    child: ElevatedButton(onPressed: () async{
                      if(email != '' && password != '') {
                        final progress = ProgressHUD.of(context);
                        progress!.show();
                        try{
                          await _auth.signInWithEmailAndPassword(email: email, password: password);
                            
                            Navigator.push(context, MaterialPageRoute(builder: (con) => Channel()));
                            print('0000000000000000000000000');
                            progress.dismiss();
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Channel()));
                        }catch(e){
                          //TODO handle the error
                          print(e);
                          progress.dismiss();
                        }
          
                      }
                    }, child: const Text("login"))),
                    Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 300,
                    height: 60,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()));
                    }, child: const Text("login in with google"))),
                    Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 300,
                    height: 60,
                    child: ElevatedButton(onPressed: (){
          
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()));
                    }, child: const Text("Registration"))),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}