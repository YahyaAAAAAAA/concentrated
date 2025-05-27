import 'package:flutter/material.dart';
import 'package:tweleve_ace/domain/entities/school_exam_path.dart';
import 'package:tweleve_ace/presentation/widgets/category_dropdown_button.dart';
import 'package:tweleve_ace/presentation/widgets/grade_dropdown_button.dart';
import 'package:tweleve_ace/presentation/widgets/subject_dropdown_button.dart';

class PathSelectorDialog extends StatelessWidget {
  const PathSelectorDialog({super.key, required this.path});

  final SchoolExamPath path;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: StatefulBuilder(
        builder:
            (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Category'),
                    CategoryDropdownButton(
                      value: path.category,
                      onChanged:
                          (value) => setState(() => path.category = value!),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Grade'),
                    GradeDropdownButton(
                      value: path.grade,
                      onChanged: (value) => setState(() => path.grade = value!),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subject'),
                    SubjectDropdownButton(
                      value: path.subject,
                      onChanged:
                          (value) => setState(() => path.subject = value!),
                    ),
                  ],
                ),
                TextField(
                  controller: TextEditingController(text: path.exam),
                  decoration: InputDecoration(
                    labelText: 'Exam Name',
                    hintText: 'R2024.....',
                  ),
                  onChanged: (value) => path.exam = value,
                ),
              ],
            ),
      ),
    );
  }
}
