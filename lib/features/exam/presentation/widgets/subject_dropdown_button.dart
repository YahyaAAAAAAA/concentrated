import 'package:flutter/material.dart';

class SubjectDropdownButton extends StatelessWidget {
  final String value;
  final void Function(String? value)? onChanged;

  const SubjectDropdownButton({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      items: [
        DropdownMenuItem(value: 'arabic', child: Text('arabic')),
        DropdownMenuItem(value: 'english', child: Text('english')),
        DropdownMenuItem(value: 'history', child: Text('history')),
        DropdownMenuItem(value: 'religion', child: Text('religion')),
        DropdownMenuItem(value: 'computer', child: Text('computer')),
      ],
      onChanged: onChanged,
    );
  }
}
