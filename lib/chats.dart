import 'package:flutter/material.dart';

import 'globals.dart' as globals;
import 'utils.dart' as utils;

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(globals.appTitle),
          actions: [
            const Icon(Icons.search),
            Container(
              width: 15,
            )
          ],
          backgroundColor: const Color(0xFF61BBFE),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 60, 56, 78),
          width: screenWidth * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, screenHeight * 0.05, 0, 0),
                alignment: Alignment.center,
                height: screenHeight * 0.18,
                child: CircleAvatar(
                  backgroundImage:
                      const AssetImage("assets/images/profile.png"),
                  radius: screenWidth * 0.075 + screenHeight * 0.025,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Super User",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, screenHeight * 0.005, 0, 0),
                alignment: Alignment.center,
                child: const Text(
                  "@superuser",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(0, screenHeight * 0.025, 0, 0),
                color: const Color(0xFF242132),
              ))
            ],
          ),
        ),
        backgroundColor: const Color(0xFF242132),
        extendBody: true,
        body: Column(
          children: const [
            ChatListUser(
              name: "Nishi",
              message: "Hey",
            ),
            ChatListUser(
              name: "Divya",
              message: "Second message",
            ),
            ChatListUser(
              name: "Sam",
              message: "Testing",
            )
          ],
        ),
      ),
    );
  }
}

class ChatListUser extends StatelessWidget {
  final String name;
  final String message;
  const ChatListUser({super.key, required this.name, required this.message});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    // ignore: sized_box_for_whitespace
    return Container(
      height: screenHeight * 0.075,
      width: screenWidth,
      child: OutlinedButton(
        onPressed: () {},
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            SizedBox(
              width: screenWidth * 0.06,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, screenHeight * 0.015, 0, 0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      // fontFamily: 'Roboto Slab',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, screenHeight * 0.007, 0, 0),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.grey,
                      // fontFamily: 'Roboto Slab',
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: const [],
            )
          ],
        ),
      ),
    );
  }
}

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
