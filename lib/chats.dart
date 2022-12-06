import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'globals.dart' as globals;

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  List<ChatBubble> dynamicChat = [];
  List<String> dynamicChatMessage = [];
  void refresh() {
    setState(() {});
    dynamicChat
        .add(ChatBubble(text: globals.globalString, isCurrentUser: true));
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Nishi';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          leading: const Icon(Icons.menu),
        ),
        body: Column(
          children: [
            const SenderAddressBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: dynamicChat,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UserMessageBox(
                    notifyParent: refresh,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void sendREQ(TextEditingController ctlr, queue) {
  http.post(
    Uri.parse('http://141.148.198.149:7777/newMessage'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "status": "ok",
      "channel": "divya",
      "ID": 69,
      "body": ctlr.text,
      "queue": queue
    }),
  );
}

class UserMessageBox extends StatelessWidget {
  final Function() notifyParent;
  const UserMessageBox({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    final userInput = TextEditingController();
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: TextField(
            controller: userInput,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  globals.message = userInput.text;
                  notifyParent();
                  sendREQ(userInput, globals.globalString);
                  userInput.clear();
                },
              ),
            ),
          ),
        ),
        Container(
          height: 15.5,
          color: Colors.black,
        )
      ],
    );
  }
}

class SenderAddressBox extends StatelessWidget {
  const SenderAddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final senderAddress = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: TextField(
            controller: senderAddress,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  globals.globalString = senderAddress.text;
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
  }) : super(key: key);
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              globals.message,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: isCurrentUser ? Colors.white : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
