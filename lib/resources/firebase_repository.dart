


import 'package:firebase_auth/firebase_auth.dart';
import 'package:skypeclone/models/user.dart';
import 'package:skypeclone/resources/firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() =>_firebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn()=>_firebaseMethods.signIn();

  Future<bool> authenticateUser(FirebaseUser user){
    Future<bool> res = _firebaseMethods.authenticateUser(user) ;
    return res ; 
  }

  Future<void> addDataToDb(FirebaseUser user)=>_firebaseMethods.addDataToDb(user);

  Future<void> signOut() => _firebaseMethods.signOut() ;

  Future<List<User>> fetchAllUsers(FirebaseUser user)=>_firebaseMethods.fetchAllUsers(user);




}