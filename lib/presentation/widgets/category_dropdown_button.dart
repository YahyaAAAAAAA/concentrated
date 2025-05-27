import 'package:flutter/material.dart';

class CategoryDropdownButton extends StatelessWidget {
  final String value;
  final void Function(String? value)? onChanged;

  const CategoryDropdownButton({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      items: [
        DropdownMenuItem(value: 'school', child: Text('school')),
        DropdownMenuItem(value: 'university', child: Text('university')),
      ],
      onChanged: onChanged,
    );
  }
}
