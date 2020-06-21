


import 'package:firebase_auth/firebase_auth.dart';
import 'package:skypeclone/resources/firebase_methods.dart';

class FirebaseRespository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() =>_firebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn()=>_firebaseMethods.signIn();

  Future<bool> authenticateUser(FirebaseUser user){
    Future<bool> res = _firebaseMethods.authenticateUser(user) ;
    return res ; 
  }

  Future<void> addDataToDb(FirebaseUser user)=>_firebaseMethods.addDataToDb(user);




}