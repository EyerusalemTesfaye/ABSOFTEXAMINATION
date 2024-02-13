import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String email;
  final String role;
  final String fullname;
  final String age;
  final String grade;
  final String token;

  User({
    required this.id,
    required this.email,
    required this.role,
    required this.fullname,
    required this.age,
    required this.grade,
    required this.token,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      role: map['role'],
      fullname: map['fullname'],
      age: map['age'],
      grade: map['grade'],
      token: map['token'],
    );
  }
}
