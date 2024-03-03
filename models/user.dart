// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String confpassword;
  final int phone;
  final String role;

  User(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.confpassword,
      required this.phone,
      required this.role});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'confpassword': confpassword,
      'phone': phone,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      confpassword: map['confpassword'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
