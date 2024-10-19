import 'package:cloud_firestore/cloud_firestore.dart';

class TazkeraModels {
  final String userId;
  final String id;
  final String title;
  final String text;
  final String username;
  final Timestamp timestamp;

  TazkeraModels({
    required this.userId,
    required this.id,
    required this.title,
    required this.text,
    required this.username,
    required this.timestamp,
  });

  factory TazkeraModels.fromJsonMap(Map<String, dynamic> json) {
    return TazkeraModels(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      text: json['text'],
      username: json['username'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'text': text,
      'username': username,
      'timestamp': timestamp,
    };
  }
}
