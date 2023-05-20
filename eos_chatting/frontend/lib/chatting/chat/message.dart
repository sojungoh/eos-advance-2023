import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eos_chatting/chatting/chat/chat_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final docs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            if (docs[index]['userId'] == user!.uid) {
              return ChatBubble(
                  docs[index]['text'], true, docs[index]['userName']);
            }
            return ChatBubble(
                docs[index]['text'], false, docs[index]['userName']);
          },
        );
      },
    );
  }
}
