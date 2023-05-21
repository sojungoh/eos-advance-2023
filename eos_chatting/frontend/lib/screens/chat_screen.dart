import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config/palette.dart';
import './main_screen.dart';
import '../chatting/chat/message.dart';
import '../chatting/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authentication = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Chat screen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authentication.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginSignUpScreen()),
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: const [
            Expanded(
              child: Messages(),
            ),
            SizedBox(
              height: 5,
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
