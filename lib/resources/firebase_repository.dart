//
//
//
//import 'dart:io';
//
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:skypeclone/models/message.dart';
//import 'package:skypeclone/models/user.dart';
//import 'package:skypeclone/provider/image_upload_provider.dart';
//import 'package:skypeclone/resources/firebase_methods.dart';
//
//class FirebaseRepository {
//  FirebaseMethods _firebaseMethods = FirebaseMethods();
//
//  Future<FirebaseUser> getCurrentUser() =>_firebaseMethods.getCurrentUser();
//
//  Future<FirebaseUser> signIn()=>_firebaseMethods.signIn();
//
//  Future<User> getUserDetails()=>_firebaseMethods.getUserDetails();
//
//  Future<bool> authenticateUser(FirebaseUser user){
//    Future<bool> res = _firebaseMethods.authenticateUser(user) ;
//    return res ;
//  }
//
//  Future<void> addDataToDb(FirebaseUser user)=>_firebaseMethods.addDataToDb(user);
//
//  Future<void> signOut() => _firebaseMethods.signOut() ;
//
//  Future<List<User>> fetchAllUsers(FirebaseUser user)=>_firebaseMethods.fetchAllUsers(user);
//
//  Future<void> addMessageToDb(Message message,sender,receiver)=> _firebaseMethods.addMessageToDb(message,receiver,sender);
//
//
//  void uploadImage({
//  @required File image ,
//  @required String receivedId ,
//  @required String senderId ,
//    @required ImageUploadProvider imageUploadProvider ,
//})=>_firebaseMethods.uploadImage(
//    image , receivedId, senderId ,imageUploadProvider,
//  );
//
//
//}