class UserModel {
  final String email;
  final String name;

  UserModel({
    required this.email,
    required this.name,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'] ?? '',
      name: data['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {"email": email, "name": name};
}
