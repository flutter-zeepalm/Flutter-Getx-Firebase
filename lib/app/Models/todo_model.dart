import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Todo {
  String id;
  String ownerid;
  String title;
  String description;
  bool isCheck;
  List<String> likes;
  List<String> dislikes;
  Todo({
    required this.id,
    required this.ownerid,
    required this.title,
    required this.description,
    required this.isCheck,
    required this.likes,
    required this.dislikes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerid': ownerid,
      'title': title,
      'description': description,
      'isCheck': isCheck,
      'likes': likes,
      'dislikes': dislikes,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      ownerid: map['ownerid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isCheck: map['isCheck'] as bool,
      likes: List<String>.from((map['likes'] as List<dynamic>)),
      dislikes: List<String>.from((map['dislikes'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
