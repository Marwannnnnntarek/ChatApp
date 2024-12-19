import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String text;
  final String senderId;
  final DateTime? timestamp;

  MessageModel({
    required this.text,
    required this.senderId,
    this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'] ?? '',
      senderId: json['senderId'] ?? '',
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderId': senderId,
      'timestamp': timestamp,
    };
  }
}
