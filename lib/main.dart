import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
import 'globals.dart' as globals;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Nishi';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
          ),
          // body: const BetterWidget(),
          // body: const SenderAddressBox(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const BetterWidget(),
              const SenderAddressBox(),
              ChatBubble(text: globals.message, isCurrentUser: true),
              const DialogExample(),
              BetterWidget(
                notifyParent: refresh,
              ),
              // ChatBubble(text: "${globals.message}", isCurrentUser: true)
            ],
          )),
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

class BetterWidget extends StatelessWidget {
  final Function() notifyParent;
  const BetterWidget({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    final userInput = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
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
              // ignore: unnecessary_const
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  globals.message = userInput.text;
                  notifyParent();
                  sendREQ(userInput, globals.globalString);
                  userInput.clear();
                  // globals.message = userInput.text;
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
              // ignore: unnecessary_const
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
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
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

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('sender name is'),
          content: Text(globals.message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
