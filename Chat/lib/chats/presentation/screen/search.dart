import 'package:chat/auth/helper/constants.dart';
import 'package:chat/auth/services/database.dart';
import 'package:chat/message/presentation/screen/body.dart';
import 'package:chat/message/presentation/screen/message_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  late QuerySnapshot searchResultSnapshot;
  late Stream userStream;
  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    // if (searchEditingController.text.isNotEmpty) {
    setState(() {
      isLoading = true;
    });
    await databaseMethods
        .searchByName(searchEditingController.text)
        .then((snapshot) {
      searchResultSnapshot = snapshot;
      // print("ke qua la ;;;;;;;;$searchResultSnapshot");
      setState(() {
        isLoading = false;
        haveUserSearched = true;
      });
    });
  }

  sendMessage(String userName) {
    List<String> users = [Constants.myName, userName];
    String chatRoomId = getChatRoomId(Constants.myName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatroomId": chatRoomId,
      
    };
    databaseMethods.addChatRoom(chatRoom, chatRoomId);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessageScreen(
              chatRoomId: chatRoomId, 
              )));
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.docs.length,
            itemBuilder: (context, index) {
              return userTile(
                searchResultSnapshot.docs[index]['imgUrl'],
                searchResultSnapshot.docs[index]['name'],
                searchResultSnapshot.docs[index]['email'],
              );
            })
        : Container();
  
  }

  Widget userTile( String profileUrl, userName,  email) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: GestureDetector(
        onTap: () {
          sendMessage(userName);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                profileUrl,
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                Text(
                  email,
                  style: TextStyle(color: Colors.grey[800], fontSize: 18),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchEditingController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Search Username...",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              //border: InputBorder.none
                            ),
                          ),
                        ),
                        //SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            initiateSearch();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.yellow, Colors.blue],
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight),
                                  borderRadius: BorderRadius.circular(40)),
                              padding: EdgeInsets.all(12),
                              child: Image.asset(
                                "assets/images/search.png",
                                height: 30,
                                width: 30,
                              )),
                        )
                      ],
                    ),
                  ),
                  userList()
                ],
              ),
            ),
    );
  }
}
