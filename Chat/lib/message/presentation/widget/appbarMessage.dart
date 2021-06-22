import 'package:chat/chats/presentation/widget/chatRoomTile.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class AppbarMessage extends StatelessWidget {
  late final ChatRoomsTile chatroom;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        BackButton(),
        // CircleAvatar(
        //   backgroundImage: AssetImage("assets/images/user_dao1.jpeg"),
        // ),
        SizedBox(width: kDefaultPadding * 0.75),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // userName,
        // chatroom.userName,      //loi
              'Vo',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "3 phút trước",
              style: TextStyle(fontSize: 12),
            )
          ],
        )
      ],
    );
  }
}
