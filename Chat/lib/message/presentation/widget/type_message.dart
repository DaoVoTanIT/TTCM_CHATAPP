


//sticker
  import 'package:flutter/material.dart';
// ignore: must_be_immutable
class StickerMessage extends StatefulWidget {
  late Function ontap;
  @override
  _StickerMessageState createState() => _StickerMessageState();
}

class _StickerMessageState extends State<StickerMessage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: (){},
                  // onSendMessage('mimi1', 2),
                  child: Image.asset(
                    'assets/images/mimi1.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                 // onPressed: () => onSendMessage('mimi2', 2),
                  onPressed: (){},
                  child: Image.asset(
                    'assets/images/mimi2.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  //onPressed: () => onSendMessage('mimi3', 2),
                  onPressed: (){},
                  child: Image.asset(
                    'assets/images/mimi3.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            Row(
              children: <Widget>[
                TextButton(
                  //onPressed: () => onSendMessage('mimi4', 2),
                  onPressed: (){},
                  child: Image.asset(
                    'assets/images/mimi4.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  //onPressed: () => onSendMessage('mimi5', 2),
                  onPressed: (){},
                  child: Image.asset(
                    'assets/images/mimi5.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  //onPressed: () => onSendMessage('mimi6', 2),
                  onPressed: (){},
                  child: Image.asset(
                    'assets/images/mimi6.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            Row(
              children: <Widget>[
                TextButton(
                  //onPressed: () => onSendMessage('mimi7', 2),
                  onPressed: (){},
                  child: Image.asset(
                    'assets/images/mimi7.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  //onPressed: () => onSendMessage('mimi8', 2),
                  onPressed: (){},
                  child: Image.asset(
                    'assets/images/mimi8.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  //onPressed: () => onSendMessage('mimi9', 2),
                  onPressed: (){},
                  child: Image.asset(
                    'assets/images/mimi9.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5)), color: Colors.white),
        padding: EdgeInsets.all(5.0),
        height: 180.0,
      ),
    );
  }
}
