// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TazkeraModels {
  final String userId;
  final String id;
  final DateTime date;
  final TimeOfDay time;

  final String text;
  TazkeraModels({
    required this.userId,
    required this.id,
    required this.text,
    required this.date,
    required this.time,
  });
  factory TazkeraModels.fromJsonMap(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date']);
    final time =
        _parseTimeOfDay(json['time']); // assumes date also contains time
    return TazkeraModels(
      userId: json['userId'],
      id: json['id'],
      text: json['text'],
      date: date,
      time: time,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'text': text,
      'date':
          date.toIso8601String(), // Convert DateTime to a string representation
      'time':
          '${time.hour}:${time.minute}', // Convert TimeOfDay to a string representation
    };
  }
}

TimeOfDay _parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  return TimeOfDay(
    hour: int.parse(parts[0]),
    minute: int.parse(parts[1]),
  );
}
