import 'package:flutter/material.dart';
import 'chats.dart' as chats;

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Copain"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Something great is waiting to be unleashed"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const chats.ChatHome(),
                      ));
                },
                child: const Text("Get Started"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
