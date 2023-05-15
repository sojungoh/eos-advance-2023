import 'package:eos_chatting/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO : 사진보고 AppBar 만들기
      appBar: AppBar(
        leading: const IconButton(
            onPressed: null,
            icon: Icon(Icons.arrow_back)
        ),
        title: const Center(
          child: Text('Chat screen'),
        ),
        actions: const [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.exit_to_app)
          ),
        ],
        backgroundColor: Palette.facebookColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('/chats/QdjBGESVjwtT0I96tfLG/message').snapshots(),
        builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  docs[index]['text'],
                  style: const TextStyle(fontSize: 20.0),
                )
              );
            }
          );
        },
      ),
    );
  }
}
