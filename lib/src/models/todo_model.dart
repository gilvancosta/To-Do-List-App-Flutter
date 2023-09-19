// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
