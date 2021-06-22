import 'package:flutter/material.dart';

Widget userTile(String profileUrl, userName, email) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    child: Column(
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
  );
}
