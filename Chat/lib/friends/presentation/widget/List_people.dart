import 'package:chat/friends/presentation/widget/profileUser..dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat/chats/domain/model/Chat.dart';
import 'package:chat/message/presentation/screen/message_Screen.dart';
import 'package:chat/message/presentation/widget/message.dart';
import 'package:chat/profile/presentation/screen/profile.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class InforListFriends extends StatelessWidget {
  String userName;
  //String userEmail;
  String profileUrl;
  InforListFriends({
    Key? key,
    required this.userName,
    // required this.userEmail,
    required this.profileUrl,
  }) : super(key: key);
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Widget getInfUser() {
    return StreamBuilder(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InforListFriends(
                      userName: snapshot.data!.docs[index]['name'],
                      // userEmail: snapshot.data!.docs[index]['email'],
                      profileUrl: snapshot.data!.docs[index]['imgUrl'],
                    );
                  })
              : Container(
                  child: Text('connect internet'),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              // Text(
              //   userEmail,
              //   style: TextStyle(color: Colors.grey[400], fontSize: 18),
              // )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              // databaseMethods.addChatRoom(chatRoom, chatRoomId);
              // MessageScreen(
              //   chatRoomId: '',
              // );
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Profile()));
              // Profile();
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.0)),
                  ),
                  builder: (context) {
                    return Expanded(
                      child: Container(
                        //height: 250.0,
                        child: Column(children: [
                          getInfUser()
                          //getInforUser(),
                          // Container(
                          //     alignment: Alignment.topLeft,
                          //     child: IconButton(
                          //         icon: Icon(
                          //           Icons.close,
                          //           size: 40,
                          //           color: Colors.green,
                          //         ),
                          //         onPressed: () {
                          //           Navigator.of(context).pop();
                          //         })),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 15),
                          //   child: Text('Gender',
                          //       style: TextStyle(
                          //           color: Colors.red[500],
                          //           fontSize: 25,
                          //           fontWeight: FontWeight.bold)),
                          // ),
                        ]),
                      ),
                    );
                  });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Add",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
