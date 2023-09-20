// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  TodoModel({
    String? cId,
    required this.title,
    required this.description,
    DateTime? cDate,
  })  : id = cId ?? const Uuid().v4(),
        date = cDate ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      cId: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      cDate: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
