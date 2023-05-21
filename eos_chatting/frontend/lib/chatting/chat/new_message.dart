import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eos_chatting/config/palette.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _controller = TextEditingController();
  late String _userEnterMessage;

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chats').add({
      'text': _userEnterMessage,
      'time': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()!['userName'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration:
                  const InputDecoration(labelText: 'Send a message ...'),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value.toString();
                });
              },
            ),
          ),
          IconButton(
            onPressed: () {
              if (_userEnterMessage.trim().isNotEmpty) {
                _sendMessage();
              }
            },
            icon: const Icon(Icons.send),
            color: Palette.iconColor,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
