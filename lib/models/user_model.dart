class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;
  final String role;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['no_hp'],
      token: json['token'],
      role: json['user']['role'],
    );
  }
}
