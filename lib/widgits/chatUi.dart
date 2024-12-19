import 'package:flutter/material.dart';
import 'package:myapp/Models/messages.dart';

class ChatScreenUi extends StatelessWidget {
  const ChatScreenUi({
    super.key,
    required this.isSender,
    required this.message,
  });

  final bool isSender;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isSender ? const Radius.circular(16) : Radius.zero,
            bottomRight: isSender ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
