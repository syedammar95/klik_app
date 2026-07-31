class UserModel {
  final int id;
  final String name;
  final String email;
  final String token;
  final DateTime? tokenExpiry;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.tokenExpiry,
  });

  // Factory method to create UserModel from API response
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      tokenExpiry: json['token_expiry'] != null
          ? DateTime.parse(json['token_expiry'])
          : null,
    );
  }

  // Convert UserModel to JSON (useful for saving locally)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'token_expiry': tokenExpiry?.toIso8601String(),
    };
  }
}
