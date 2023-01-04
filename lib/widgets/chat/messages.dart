import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat').orderBy("createdAt", descending: true).snapshots(),
        builder: (ctx, chatSnapShot) {
          if (chatSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocx = chatSnapShot.data!.docs;
          return ListView.builder(
              reverse: true,
              itemCount: chatDocx.length,
              itemBuilder: (ctx, index) => Text(chatDocx[index]['text'].toString()));
        });
  }
}
