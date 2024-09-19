// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TazkeraModels {
  final String userId;
  final String id;
  final String dateTime;

  final String text;
  TazkeraModels({
    required this.userId,
    required this.id,
    required this.text,
    required this.dateTime,
  });
  factory TazkeraModels.fromJsonMap(Map<String, dynamic> json) {
    return TazkeraModels(
      userId: json['userId'],
      id: json['id'],
      text: json['text'],
      dateTime: json['dateTime'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'text': text, 'date': dateTime};
  }
}
