import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skypeclone/provider/image_upload_provider.dart';
import 'package:skypeclone/provider/user_provider.dart';
import 'package:skypeclone/resources/auth_methods.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/screens/home_screen.dart';
import 'package:skypeclone/screens/login_screen.dart';
import 'package:skypeclone/screens/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ImageUploadProvider(),),
        ChangeNotifierProvider(create: (_)=>UserProvider(),),
      ],
      child: MaterialApp(
        title: 'Skype Clone',
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          '/search_screen' : (context)=>SearchScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: FutureBuilder(
            future:  _authMethods.getCurrentUser(),
            builder: (context,AsyncSnapshot<FirebaseUser> snapshot){
              if(snapshot.hasData){
                print(snapshot) ;
                return HomeScreen() ;
              }else{
                return LoginScreen();
              }

            }),
      ),
    );


  }
}


