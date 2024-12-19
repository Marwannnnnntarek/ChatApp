import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Models/messages.dart';
import 'package:myapp/widgits/buildMessage.dart';

class MessagesList extends StatelessWidget {
  final Stream<QuerySnapshot> messageStream;

  const MessagesList({
    super.key,
    required this.messageStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong. Please try again later.'),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages yet.'));
        }

        // Map Firestore documents to MessageModel objects
        List<MessageModel> messagesList = snapshot.data!.docs.map((doc) {
          return MessageModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        return ListView.builder(
          reverse: true, // Display the latest messages at the top
          itemCount: messagesList.length,
          itemBuilder: (context, index) {
            final message = messagesList[index];
            bool isSender = message.senderId ==
                FirebaseAuth.instance.currentUser?.email; // Check sender
            return BuildMessage(isSender: isSender, message: message);
          },
        );
      },
    );
  }
}
