import 'package:flutter/material.dart';
import 'package:skypeclone/models/log.dart';
import 'package:skypeclone/resources/local_db/repository/log_respository.dart';
import 'package:skypeclone/screens/pageviews/logs/widgets/floating_column.dart';
import 'package:skypeclone/screens/pageviews/logs/widgets/log_list_container.dart';
import 'package:skypeclone/screens/pickup/pickup_layout.dart';
import 'package:skypeclone/utils/universal_variables.dart';
import 'package:skypeclone/widgets/skype_appbar.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: SkypeAppBar(
          title: "Calls",
          actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/search_screen");
                },
              ),

            ],

        ),
        floatingActionButton: FloatingColumn(),
        body: Padding(padding: EdgeInsets.only(left: 15),child: LogListContainer(),),

      ),
    );
  }
}
