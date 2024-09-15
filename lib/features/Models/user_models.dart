class UserModels {
  final String id;
  final String name;
  final String email;
  final String image;
  UserModels({
    required this.email,
    required this.name,
    required this.id,
    required this.image,
  });
  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      email: json['email'],
      name: json['name'],
      id: json['id'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'id': id,
      'image': image,
    };
  }
}
