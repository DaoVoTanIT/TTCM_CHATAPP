import 'package:flutter/material.dart';

import '../../../constants.dart';

class SendMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.mic, color: kPrimaryColor),
      SizedBox(width: kDefaultPadding),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [
              Icon(
                Icons.sentiment_satisfied_alt_outlined,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.64),
              ),
              SizedBox(width: kDefaultPadding / 4),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type message",
                    border: InputBorder.none,
                  ),
                ),
              ),
              //  GestureDetector(
              //       onTap: () {
              //         sendMessage();
              //       },
              //      child: Container(
              //           width: 40,
              //           height: 40,
              //           decoration: BoxDecoration(
              //               gradient: LinearGradient(
              //                   colors: [kPrimaryColor, kWarninngColor],
              //                   begin: FractionalOffset.topLeft,
              //                   end: FractionalOffset.bottomRight),
              //               borderRadius: BorderRadius.circular(40)),
              //           child: Container(
              //               alignment: Alignment.center,
              //               child: Icon(Icons.send,
              //                   color: kContentColorDarkTheme))),

              //  ),
              // Icon(
              //   Icons.send,
              //   color: Theme.of(context)
              //       .textTheme
              //       .bodyText1!
              //       .color!
              //       .withOpacity(0.64),
              // ),
              SizedBox(width: kDefaultPadding / 4),
              Icon(
                Icons.camera_alt_outlined,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.64),
              ),
            ],
          ),
          // Row(children: [
          // Expanded(
          //   child: TextField(
          //       controller: messageTextEditingController,
          //       decoration: InputDecoration(
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10)),
          //         hintText: "Message ...",
          //         hintStyle: TextStyle(
          //           color: Colors.black,
          //           fontSize: 16,
          //         ),
          //       )),
          // ),
          // SizedBox(width: 16),
          // GestureDetector(
          //   onTap: () {
          //     sendMessage();
          //   },
          //  child: Container(
          //       width: 40,
          //       height: 40,
          //       decoration: BoxDecoration(
          //           gradient: LinearGradient(
          //               colors: [kPrimaryColor, kWarninngColor],
          //               begin: FractionalOffset.topLeft,
          //               end: FractionalOffset.bottomRight),
          //           borderRadius: BorderRadius.circular(40)),
          //       child: Container(
          //           alignment: Alignment.center,
          //           child: Icon(Icons.send,
          //               color: kContentColorDarkTheme))),
          //                     // child: ChatInputField(),

          //),

          // ]
          // ),
        ),
      )
    ]);
  }
}
