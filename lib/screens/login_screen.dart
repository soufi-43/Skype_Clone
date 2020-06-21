import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/screens/home_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skypeclone/utils/universal_variables.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRespository _repository = FirebaseRespository();

  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Stack(
        children: [
          Center(
            child: LoginButton(),
          ),
          isLoginPressed
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget LoginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: UniversalVariables.senderColor,
      child: FlatButton(
        padding: EdgeInsets.all(35),
        onPressed: () => performLogin(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'LOGIN',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  void performLogin() {

    setState(() {
      isLoginPressed = true ;
    });


    _repository.signIn().then((FirebaseUser user) {
      if (user != null) {
        authenticateUser(user);
      } else {
        print('there is an error');
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false ;
      });
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomeScreen();
              },
            ),
          );
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ),
        );
      }
    });
  }
}
