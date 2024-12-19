import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgits/chatInput.dart';
import 'package:myapp/widgits/mesagesList.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      
            SizedBox(width: 10),
            Text(
              'Chat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: MessagesList(
                messageStream: messages
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
              ),
            ),
            ChatInput(controller: _controller, onSend: _sendMessage),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final messageText = _controller.text.trim();
    if (messageText.isEmpty) return;

    final userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail == null) {
      print("Error: User email not found.");
      return;
    }

    messages.add({
      'text': messageText,
      'senderId': userEmail,
      'timestamp': FieldValue.serverTimestamp(),
    });
    _controller.clear();
  }
}
