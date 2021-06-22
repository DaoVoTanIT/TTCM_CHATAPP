
import 'package:chat/message/presentation/widget/text_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chat/auth/helper/constants.dart';
import 'package:chat/auth/services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';

class MessageScreen extends StatefulWidget {
  final String chatRoomId;
   MessageScreen({
    Key? key,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController messageTextEditingController =
      new TextEditingController();
  DatabaseMethods database = new DatabaseMethods();
  late Stream<QuerySnapshot> chatMessageStream;
  late QuerySnapshot searchResultSnapshot;
  late String messageId = "";
  Widget chatMessage() {
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return TextMessage(
                      snapshot.data!.docs[index]["message"],
                      snapshot.data!.docs[index]["sendBy"] == Constants.myName,
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
        });
  }
  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
      "message": messageTextEditingController.text,
        "sendBy": Constants.myName,
        'time': DateTime.now(),
      };
      //  if (widget.chatRoomId == "") {
      //   chatRoomId = randomAlphaNumeric(12);
      // }
      database.addMessage(widget.chatRoomId, messageMap);
      messageTextEditingController.text = "";
    }  else {
      Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: Colors.black, textColor: Colors.red);
    }
  }

  // String groupChatId = "";

  // late String peerId;
  // late String peerAvatar;
  // String? id;
  // final ScrollController listScrollController = ScrollController();
  // void onSendMessage() {
  //   if (messageTextEditingController.text.isNotEmpty) {
  //     var documentReference = FirebaseFirestore.instance
  //         .collection('chats')
  //         .doc(groupChatId)
  //         .collection(groupChatId)
  //         .doc(DateTime.now().millisecondsSinceEpoch.toString());

  //     FirebaseFirestore.instance.runTransaction((transaction) async {
  //       transaction.set(
  //         documentReference,
  //         {
  //           'idFrom': id,
  //           'idTo': peerId,
  //           'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
  //           // 'content': content,
  //           // 'type': type
  //         },
  //       );
  //     });
  //     listScrollController.animateTo(0.0,
  //         duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: 'Nothing to send',
  //         backgroundColor: Colors.black,
  //         textColor: Colors.red);
  //   }
  // }
  //  sendMessage() {
  //   if (messageTextEditingController.text != "") {
  //     String message = messageTextEditingController.text;

  //     var lastMessageTs = DateTime.now();

  //     Map<String, dynamic> messageInfoMap = {
  //       "message": message,
  //       "sendBy": Constants.myName,
  //       "time": lastMessageTs,
  //     };
  //     DatabaseMethods()
  //         .addMessage(widget.chatRoomId, messageId,messageInfoMap )
  //         .then((value) {
  //       Map<String, dynamic> lastMessageInfoMap = {
  //         "lastMessage": message,
  //         "lastMessageSendTs": lastMessageTs,
  //        // "lastMessageSendBy": myUserName
  //       };
  //       DatabaseMethods().updateLastMessageSend(widget.chatRoomId, lastMessageInfoMap);
  //     });
  //   }else {
  //     Fluttertoast.showToast(
  //         msg: 'Nothing to send',
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white);
  //   }
  // }

  @override
  void initState() {
    database.getChats(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              BackButton(),
              // CircleAvatar(
              //   backgroundImage: AssetImage(),
              // ),
              SizedBox(width: kDefaultPadding * 0.75),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dao',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "3 phút trước",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.local_phone),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: () {},
            ),
            SizedBox(width: kDefaultPadding / 2),
          ],
        ),
        body: Container(
            child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: chatMessage(),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Row(
                  children: <Widget>[
                    // Button send image
                    Material(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.0),
                        child: IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () {},
                          color: primaryColor,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    Material(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.0),
                        child: IconButton(
                          icon: Icon(Icons.face),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => StickerMessage()));
                            buildSticker(context);
                          },
                        ),
                      ),
                      color: Colors.white,
                    ),

                    // Edit text
                    Flexible(
                      child: Container(
                        child: TextField(
                          onSubmitted: (value) {
                            // onSendMessage(textEditingController.text, 0);
                            sendMessage();
                          },
                          style: TextStyle(fontSize: 15.0),
                          controller: messageTextEditingController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          //focusNode: focusNode,
                        ),
                      ),
                    ),

                    // Button send message
                    Material(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [kPrimaryColor, kWarninngColor],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () => sendMessage()),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(width: 0.5)),
                    color: Colors.white),
              ))
        ])));
  }
  void buildSticker(BuildContext context ){ 
     showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {  
       return  Expanded(
        child: Container(
          height: 500,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: ()=> sendMessage(),
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
                    onPressed: ()=> sendMessage(),
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
        ));
      
      }, 
    );
  }
}





