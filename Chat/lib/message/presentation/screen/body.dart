import 'package:chat/constants.dart';
import 'package:chat/message/domain/model/ChatMessage.dart';
import 'package:chat/message/presentation/widget/chat_input_field.dart';
import 'package:chat/message/presentation/widget/message.dart';
import 'package:flutter/material.dart';



class BodyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demeChatMessages[index]),
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
