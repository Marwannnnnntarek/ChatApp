

import 'package:flutter/material.dart';
import 'package:myapp/Models/messages.dart';
import 'package:myapp/widgits/chatUi.dart';

class BuildMessage extends StatelessWidget {
  final bool isSender;
  final MessageModel message;

  const BuildMessage({
    super.key,
    required this.isSender,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ChatScreenUi(isSender: isSender, message: message);
  }
}
