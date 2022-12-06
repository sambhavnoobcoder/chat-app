import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'chats.dart' as chats;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            globals.appTitle,
            style: TextStyle(fontFamily: 'Roboto Slab'),
          ),
          // 0xFF61BBFE
          // 0xFF4E00FE
          backgroundColor: const Color(0xFF61BBFE),
        ),
        backgroundColor: const Color(0xFF242132),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Something great is waiting to be unleashed",
                style:
                    TextStyle(fontFamily: 'Roboto Slab', color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => const Color(0xFF61BBFE)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const chats.UserChat(),
                      ));
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontFamily: 'Roboto Slab'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
