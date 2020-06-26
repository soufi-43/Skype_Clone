import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:skypeclone/models/user.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/utils/universal_variables.dart';
import 'package:skypeclone/widgets/custom_tile.dart';

import 'chatscreens/chat_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FirebaseRepository _respository = FirebaseRepository();

  List<User> userList;

  String query = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _respository.getCurrentUser().then((FirebaseUser user) {
      _respository.fetchAllUsers(user).then((List<User> list) {
        setState(() {
          userList = list;
          print(userList.length);
        });
      });
    });
  }

  buildSuggestions(String query) {
    final List<User> suggestionsList = query.isEmpty
        ? []
        : userList.where((User user) {
            String _getUsername = user.username.toLowerCase();
            String _query = query.toLowerCase();
            String _getName = user.name.toLowerCase();
            bool matchesUsername = _getUsername.contains(_query);
            bool matchesName = _getName.contains(_query);



            return (matchesUsername || matchesName);
          }).toList();
    return ListView.builder(
        itemCount: suggestionsList.length,
        itemBuilder: (context, index) {
          User searchedUser = User(
            uid: suggestionsList[index].uid,
            profilePhoto: suggestionsList[index].profilePhoto,
            name: suggestionsList[index].name,
            username: suggestionsList[index].username,
          );

          return CustomTile(
            mini: false,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>ChatScreen(
                  receiver  : searchedUser
                ),
              ));
            },
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(searchedUser.profilePhoto),
            ),
            title: Text(
              searchedUser.username,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              searchedUser.name,
              style: TextStyle(color: UniversalVariables.greyColor),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: searchAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggestions(query),
      ),
    );
  }

  searchAppBar(BuildContext context) {
    return GradientAppBar(
      backgroundColorEnd: UniversalVariables.gradientColorEnd,
      backgroundColorStart: UniversalVariables.gradientColorStart,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              print(val);
              setState(() {
                query = val;
              });
            },
            cursorColor: UniversalVariables.blackColor,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => searchController.clear());
                  }),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0x88ffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
