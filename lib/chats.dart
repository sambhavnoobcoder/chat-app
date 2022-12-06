import 'package:flutter/material.dart';

import 'globals.dart' as globals;
import 'utils.dart' as utils;

class UserChat extends StatefulWidget {
  const UserChat({super.key});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  List<ChatBubble> dynamicChat = [];
  List<String> dynamicChatMessage = [];
  void refresh() {
    setState(() {});
    dynamicChat
        .add(ChatBubble(text: globals.globalString, isCurrentUser: true));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: globals.appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(globals.appTitle),
          leading: const Icon(Icons.menu),
        ),
        body: Column(
          children: [
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
                  utils.sendREQ(userInput, globals.globalString);
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
