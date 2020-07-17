import 'package:flutter/material.dart';
import 'package:skypeclone/models/log.dart';
import 'package:skypeclone/resources/local_db/repository/log_respository.dart';
import 'package:skypeclone/utils/universal_variables.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Center(
        child: FlatButton(
          onPressed: () {
            LogRepository.init(isHive: true);
            LogRepository.addLogs(Log()) ;
          },
          child: Text("click Me"),
        ),
      ),
    );
  }
}
