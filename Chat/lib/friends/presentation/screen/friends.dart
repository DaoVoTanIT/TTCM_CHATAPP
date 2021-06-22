import 'package:chat/friends/presentation/widget/List_people.dart';
import 'package:chat/friends/presentation/widget/profileUser..dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ListPeople extends StatefulWidget {
  @override
  _ListPeopleState createState() => _ListPeopleState();
}

class _ListPeopleState extends State<ListPeople> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Widget getUser() {
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
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          title: Text('Friends',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              color: kPrimaryColor,
              onPressed: () {},
              // onPressed: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
              // },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: getUser()),
          ],
        ));
  }
}
