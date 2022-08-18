import 'dart:convert';


class UserModel {
  String uid;
  String? email;
  String? name;
  String? pic;
  UserModel({
    required this.uid,
    this.email,
    this.name,
    this.pic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uid,
      'email': email,
      'name': name,
      'pic': pic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      pic: map['pic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
