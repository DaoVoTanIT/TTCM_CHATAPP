import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

typedef onTapItem = void Function();

class ProfileItem extends StatefulWidget {
  final IconData headerIcon;
  final String headerText;
  final String text;
  final onTapItem onTap;

  const ProfileItem(
      {Key? key,
      required this.headerIcon,
      required this.headerText,
      required this.text,
      required this.onTap})
      : super(key: key);

  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            onTap: widget.onTap,
            leading: Icon(
              widget.headerIcon,
              color: Colors.green[400],
            ),
            title: Text(
              widget.headerText,
              style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono'),
              //style: GoogleFonts.lato(fontStyle: FontStyle.italic)
            ),
            subtitle: Text(
              widget.text,
              style: TextStyle(fontSize: 10, fontFamily: 'RobotoMono'),
            ),
            // trailing: Switch(
            //   value: isSwitched,
            //   onChanged: (bool value) {
            //     setState(() {
            //       isSwitched = value;
            //       print('SWITCH $isSwitched');
            //     });
            //   },
            //   activeColor: Colors.yellow,
            //   activeTrackColor: Colors.orangeAccent[200],
            // )
            trailing: Icon(Icons.arrow_forward_ios_outlined, size: 20),
          )
        ]);
  }
}

