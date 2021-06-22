import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:chat/auth/helper/constants.dart';
import 'package:chat/auth/model/user_chat.dart';
import 'package:chat/auth/services/database.dart';
import 'package:chat/chats/presentation/screen/chats_Room.dart';
import 'package:chat/chats/presentation/widget/widget_chatRoom.dart';
import 'package:chat/message/presentation/screen/message_Screen.dart';
import 'package:chat/message/presentation/widget/text_message.dart';

import '../../../constants.dart';

// // ignore: must_be_immutable
class ChatRoomsTile extends StatefulWidget {
  final String chatRoomId, userName;

  ChatRoomsTile({Key? key, required this.chatRoomId, required this.userName})
      : super(key: key);
  @override
  _ChatRoomsTileState createState() => _ChatRoomsTileState();
}

class _ChatRoomsTileState extends State<ChatRoomsTile> {
  late Stream<QuerySnapshot> chatMessageStream;
  late QuerySnapshot searchResultSnapshot;
  String profilePicUrl = "", name = "", username = "";

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.userName, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);
    print(
        "something bla bla ${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["name"]}  ${querySnapshot.docs[0]["imgUrl"]}");
    name = "${querySnapshot.docs[0]["name"]}";
    profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MessageScreen(
                        chatRoomId: widget.chatRoomId,
                      )));
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDialogBox(
                    title: 'Delete',
                    descriptions: 'Are you sure you want to delete?',
                    yes: 'Yes',
                    press: () {
                      DatabaseMethods().deleteItemMessage(widget.chatRoomId);
                      Navigator.pop(context, true);
                    });
              });
        },
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: kWarninngColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(widget.userName.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
    
  }
}

Widget buildItem(BuildContext context, DocumentSnapshot? document) {
  if (document != null) {
    UserChat userChat = UserChat.fromDocument(document);
    if (userChat.id == '') {
      return SizedBox.shrink();
    } else {
      return Container(
        child: TextButton(
          child: Row(
            children: <Widget>[
              Material(
                child: userChat.photoUrl.isNotEmpty
                    ? Image.network(
                        userChat.photoUrl,
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                                value: loadingProgress.expectedTotalBytes !=
                                            null &&
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, object, stackTrace) {
                          return Icon(
                            Icons.account_circle,
                            size: 50.0,
                            color: Colors.grey,
                          );
                        },
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: Colors.grey,
                      ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text('${userChat.name}',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'OverpassRegular',
                                fontWeight: FontWeight.w300)),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'About me: ${userChat.email}',
                          maxLines: 1,
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MessageScreen(
            //       chatRoomId: chatRoomId,
            //     ),
            //   ),
            // );
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  } else {
    return SizedBox.shrink();
  }
}
