import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Name'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/CHlEaCBHvolijprB0dj2/messages').orderBy("text",descending:false)
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if(streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(10),
              child:  Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() {
          FirebaseFirestore.instance
              .collection('chats/CHlEaCBHvolijprB0dj2/messages').add({
            'text' : 'This was added by clicking the button'
          });
        }),
      ),
    );
  }
}
