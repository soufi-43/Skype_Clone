import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/screens/home_screen.dart';
import 'package:skypeclone/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    FirebaseRespository _repository  = FirebaseRespository();


    return MaterialApp(
      title: 'Skype Clone',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future:  _repository.getCurrentUser(),
          builder: (context,AsyncSnapshot<FirebaseUser> snapshot){
            if(snapshot.hasData){
              print(snapshot) ;
              return HomeScreen() ;
            }else{
              return LoginScreen();
            }

          }),
    );
  }
}


