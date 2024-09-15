// ignore_for_file: public_member_api_docs, sort_constructors_first
class TazkeraModels {
  final String userId;
  final String id;
  final String title;
  final String text;
  TazkeraModels({
    required this.userId,
    required this.id,
    required this.title,
    required this.text,
  });
  factory TazkeraModels.fromJsonMap(Map<String, dynamic> json) {
    return TazkeraModels(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      text: json['text'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'text': text,
    };
  }
}
