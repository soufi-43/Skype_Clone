import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skypeclone/constatnts/strings.dart';
import 'package:skypeclone/models/call.dart';
import 'package:skypeclone/models/log.dart';
import 'package:skypeclone/models/user.dart';
import 'package:skypeclone/resources/call_methods.dart';
import 'package:skypeclone/resources/local_db/repository/log_respository.dart';
import 'package:skypeclone/screens/callscreens/call_screen.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();
  static dial({User from , User to , context})async{
    Call call = Call(
      callerId: from.uid ,
      callerName: from.name ,
      callerPic: from.profilePhoto,
      receiverId: to.uid ,
      receiverName: to.name ,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString() ,
    );
    Log log = Log(
      callerName: from.name , 
      callerPic: from.profilePhoto , 
      callStatus: CALL_STATUS_DIALLED , 
      receiverPic: to.profilePhoto,
      receiverName: to.name , 
      timestamp: DateTime.now().toString() ,
    )  ; 
    bool callMade = await callMethods.makeCall(call: call);
    call.hasDialled = true ;

    if(callMade){
      LogRepository.addLogs(log) ;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CallScreen(call:call)));

    }

  }


}