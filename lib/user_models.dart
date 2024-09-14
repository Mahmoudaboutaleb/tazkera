class UserModels {
  final String id;
  final String name;
  final String email;
  final String images;
  UserModels({
    required this.email,
    required this.name,
    required this.id,
    required this.images,
  });
  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      email: json['email'],
      name: json['name'],
      id: json['id'],
      images: json['images'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'id': id,
      'images': images,
    };
  }
}
