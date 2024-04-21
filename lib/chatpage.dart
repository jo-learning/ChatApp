import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Chat extends StatefulWidget {
  Chat({Key? key, required  this.id, required  this.name});
  final int id;
  final String name;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _messagecontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String messagem = '';
  Text text = Text('');
  User? user;
  List messages = [];

  void getmessage() async{
    final current = await _auth.currentUser;
    if (current != null){
      user = current;
      print(user!.email);
    }
    await _firestore.collection(widget.name).get().then((value){ 
      for(var message in value.docs){
        print(message.data());
        messages.add(message.data());
      }
      text = Text(messages[0]['message']);
    }
    );
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    getmessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Group Name", style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepPurple,),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection(widget.name).snapshots(), 
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                  final messages = snapshot.data!.docs.reversed;
                  List<Widget> messageWidgets = [];
                  for (var messag in messages){
                    List messa = [];
                    messa.add(messag.data());
                    final messagetext = messa[0]['message'];
                    final messageSender = messa[0]['sender'];
                    final messageWidget = chats(messageSender: messageSender, messagetext: messagetext);
                    messageWidgets.add(messageWidget);
                  }
                  return ListView(
                    reverse: true,
                    children: messageWidgets,
                  );
              },
              )
            ),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Expanded(child: TextField(
                  controller: _messagecontroller,
                  onChanged: (value){
                    messagem = value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Message...",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    )
                  ),
                ), ),
                Container(
                  height: 50, 
                  child: ElevatedButton(
                    onPressed: (){
                      //TODO send message to the server
                      _firestore.collection(widget.name).add(
                        {
                          'sender': user!.email,
                          'message': messagem
                        }
                      );
                      _messagecontroller.clear();
                    },
                    child: const Icon(Icons.send),
                    )
                  )
              ],
            ),
          )
        ]
        ),
    );
  }
  Widget chats ({String? messageSender, String? messagetext}){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:user!.email == messageSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$messageSender', style: const TextStyle(color: Colors.grey, fontSize: 12),),
          Material(
            borderRadius:user!.email == messageSender ? const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : const BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          elevation: 5,
          color: user!.email == messageSender ? Colors.blue : Colors.deepPurple,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text('$messagetext', style: const TextStyle(color: Colors.white),)
            ),
        ),
        ]
        
      ),
    );
  }
}