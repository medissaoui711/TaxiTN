import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String phone;
  final String? email;
  final String name;
  final String? avatarUrl;
  final String role;
  final bool isVerified;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.phone,
    this.email,
    required this.name,
    this.avatarUrl,
    required this.role,
    required this.isVerified,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'],
      role: json['role'] ?? 'customer',
      isVerified: json['is_verified'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'name': name,
      'avatar_url': avatarUrl,
      'role': role,
      'is_verified': isVerified,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, phone, email, name, avatarUrl, role, isVerified, createdAt];
}
