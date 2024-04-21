
import 'package:chatapp/adminpage.dart';
import 'package:chatapp/chatpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Channel extends StatefulWidget {
  // Channel({Key key}) : super(key: key);

  @override
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? loginuser;
  List groups = [];


  void getcurrentuser()async{
    try{
    final user = await _auth.currentUser;
    if (user != null){
      loginuser = user;
      print(loginuser!.email);
    }
    // await _firestore.collection('channel').where('email', isEqualTo: "${loginuser!.email}").get().then((value){ 

    //   for (var val in value.docs){
    //     groups.add(val.data());
    //   }
    //   setState(() {
        
    //   });
    //   print(groups);
    //   });

    await _firestore.collection('channel').where('email', isEqualTo: "${loginuser!.email}").get().then(
      (value){
      for (var val in value.docs){
        groups.add(val.data());
      }
      setState(() {
        
      });
      }
    ).asStream();

    }catch(e){
      print(e);
    }
    
  }


  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Channel', style: TextStyle(color: Colors.white),), 
        backgroundColor: Colors.deepPurple,
        actions: [
        loginuser?.email == "yohannesguesh01@gmail.com" ? IconButton(
            color: Colors.white,
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) => AdminPage())));
          }, icon: const Icon(Icons.hdr_plus)) : IconButton(onPressed: (){}, icon: const Icon(Icons.logout))
        ],
        ),
      body: groups != [] ? ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index){
          return Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: ListTile(
              //TODO add image to the listtile
              leading:Text(index.toString()),
              tileColor: Colors.deepPurple,
              title: Text(groups[index]['group']),
              textColor: Colors.white,
              onTap: (){
                //TODO on press navigate to the chat section
                Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(id: index, name: groups[index]['group'],)));
                // print("pressed" + index.toString());
              },
            ),
          );
        }): Center(child: Text("to create group or add to group contact the provider yohannesguesh01@gmail.com \n Thank you for using this service"),),
    );
  }
}