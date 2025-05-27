import 'package:flutter/material.dart';

class GradeDropdownButton extends StatelessWidget {
  final String value;
  final void Function(String? value)? onChanged;

  const GradeDropdownButton({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      items: [
        DropdownMenuItem(value: '1', child: Text('1')),
        DropdownMenuItem(value: '2', child: Text('2')),
        DropdownMenuItem(value: '3', child: Text('3')),
        DropdownMenuItem(value: '4', child: Text('4')),
        DropdownMenuItem(value: '5', child: Text('5')),
        DropdownMenuItem(value: '6', child: Text('6')),
        DropdownMenuItem(value: '7', child: Text('7')),
        DropdownMenuItem(value: '8', child: Text('8')),
        DropdownMenuItem(value: '9', child: Text('9')),
        DropdownMenuItem(value: '10', child: Text('10')),
        DropdownMenuItem(value: '11.1', child: Text('11.1')),
        DropdownMenuItem(value: '11.2', child: Text('11.2')),
        DropdownMenuItem(value: '11.3', child: Text('11.3')),
        DropdownMenuItem(value: '12.1', child: Text('12.1')),
        DropdownMenuItem(value: '12.2', child: Text('12.2')),
        DropdownMenuItem(value: '12.3', child: Text('12.3')),
      ],
      onChanged: onChanged,
    );
  }
}
