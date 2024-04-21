import 'package:chatapp/loginpage.dart';
import 'package:flutter/material.dart';
// import 'package:chatapp/registerpage.dart';
// import 'package:chatapp/chatpage.dart';
// import 'package:chatapp/channelpage.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAGEN8QHT7ZwGw4y7i1mJs0OuvkrAnV4xo", 
      appId: "1:382977207874:android:374731e8357bae4b3c07db", 
      messagingSenderId: "382977207874", 
      projectId: "pristine-lodge-406921"
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}
