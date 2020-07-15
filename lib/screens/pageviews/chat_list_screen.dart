import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skypeclone/models/contact.dart';
import 'package:skypeclone/provider/user_provider.dart';
import 'package:skypeclone/resources/auth_methods.dart';
import 'package:skypeclone/resources/chat_methods.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/screens/pageviews/widgets/contact_view.dart';
import 'package:skypeclone/screens/pageviews/widgets/new_chat_button.dart';
import 'package:skypeclone/screens/pageviews/widgets/quiet_box.dart';
import 'package:skypeclone/screens/pageviews/widgets/user_circle.dart';
import 'package:skypeclone/screens/pickup/pickup_layout.dart';
import 'package:skypeclone/utils/universal_variables.dart';
import 'package:skypeclone/utils/utilities.dart';
import 'package:skypeclone/widgets/appBar.dart';
import 'package:skypeclone/widgets/custom_tile.dart';

class ChatListScreen extends StatelessWidget {
  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: UserCircle(),
      centerTitle: true,
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
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: customAppBar(context),
        floatingActionButton: NewChatButton(),
        body: ChatListContainer(),
      ),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(userId: userProvider.getUser.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var doclist = snapshot.data.documents;

              if (doclist.isEmpty) {
                return QuietBox();
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: doclist.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(doclist[index].data);

                  return ContactView(contact);
                },
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
