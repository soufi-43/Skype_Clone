import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/utils/universal_variables.dart';
import 'package:skypeclone/utils/utilities.dart';
import 'package:skypeclone/widgets/appBar.dart';
import 'package:skypeclone/widgets/custom_tile.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

final FirebaseRespository _respository = FirebaseRespository();

class _ChatListScreenState extends State<ChatListScreen> {
  String currentUserId;
  String initials;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _respository.getCurrentUser().then((user) {
      setState(() {
        currentUserId = user.uid;
        initials = Utils.getInitials(user.displayName);
      });
    });
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: UserCircle(initials==null?"" :initials),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {},
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: customAppBar(context),
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(currentUserId),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  String currentUserId;

  ChatListContainer(this.currentUserId);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 2,
        itemBuilder: (context, index) {
          return CustomTile(
            mini: false,
            onTap: () {},
            title: Text(
              'The CS Guy',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Arial",
                fontSize: 19,
              ),
            ),
            subtitle: Text(
              'Hello',
              style: TextStyle(
                color: UniversalVariables.greyColor,
                fontSize: 14,
              ),
            ),
            leading: Container(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        "https://yt3.ggpht.com/a/AGF-l7_zT8BuWwHTymaQaBptCy7WrsOD72gYGp-puw=s900-c-k-c0xffffffff-no-rj-mo"),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UniversalVariables.onlineDotColor,
                        border: Border.all(
                          color: UniversalVariables.blackColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserCircle extends StatelessWidget {
  final String text;

  UserCircle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: UniversalVariables.separatorColor),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: UniversalVariables.lightBlueColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: UniversalVariables.blackColor,
                  width: 2,
                ),
                color: UniversalVariables.onlineDotColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: UniversalVariables.fabGradient,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: EdgeInsets.all(15),
    );
  }
}
