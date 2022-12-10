import 'package:flutter/material.dart';

class TodoState {
  List<String> tags = [];

  final tagsController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
}
