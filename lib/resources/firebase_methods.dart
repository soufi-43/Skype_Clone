import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skypeclone/constatnts/strings.dart';
import 'package:skypeclone/models/message.dart';
import 'package:skypeclone/models/user.dart';
import 'package:skypeclone/provider/image_upload_provider.dart';
import 'package:skypeclone/utils/utilities.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  static final _firestore = Firestore.instance ;
  StorageReference _storageReference;

  User user = User();

  static final CollectionReference _userCollection = _firestore.collection(USERS_COLLECTION);


Future<User> getUserDetails()async {
  FirebaseUser currentUser = await getCurrentUser() ;
  DocumentSnapshot documentSnapshot = await _userCollection.document(currentUser.uid).get() ;

  return User.fromMap(documentSnapshot.data);
}



  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;

    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _signInAuthentication.idToken,
        accessToken: _signInAuthentication.accessToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser user = result.user;

    return user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    print(docs.length);

    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    user = User(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      profilePhoto: currentUser.photoUrl,
      username: username,
    );
    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<User>> fetchAllUsers(FirebaseUser currentUser) async {
    List<User> userList = List<User>();

    QuerySnapshot querySnapshot =
        await firestore.collection(USERS_COLLECTION).getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        userList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return userList;
  }

  Future<void> addMessageToDb(
      Message message, User sender, User receiver) async {
    var map = message.toMap();

    await firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    await firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Future<String> uploadImageToStorage(File image) async {
   try{
     _storageReference = FirebaseStorage.instance
         .ref()
         .child('${DateTime.now().millisecondsSinceEpoch}');

     StorageUploadTask _storageUploadTask = _storageReference.putFile(image) ;

     var url = await (await _storageUploadTask.onComplete).ref.getDownloadURL();
     return url ;

   }catch(e){
     print(e) ;
     return null ;

   }
  }

  void setImageMsg(String url , String receivedId, String senderId)async{
    Message _message  ;
    _message = Message.imageMessage(
      message: "IMAGE",
      receiverId: receivedId ,
      senderId: senderId ,
      photoUrl: url ,
      timestamp: Timestamp.now() ,
      type: 'image',
    );

    var map = _message.toImageMap();

    await firestore
        .collection(MESSAGES_COLLECTION)
        .document(_message.senderId)
        .collection(_message.receiverId)
        .add(map);

    await firestore
        .collection(MESSAGES_COLLECTION)
        .document(_message.receiverId)
        .collection(_message.senderId)
        .add(map);

  }

  void uploadImage(File image, String receivedId, String senderId,ImageUploadProvider imageUploadProvider) async {

    imageUploadProvider.setToLoading() ;


    String url = await uploadImageToStorage(image);

    imageUploadProvider.setToIdle() ;
    setImageMsg(url,receivedId,senderId) ;
  }
}
