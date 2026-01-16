import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    super.key,
    required this.label,
    this.hint,
    required this.onChanged
  });

  final String label;
  final String? hint;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
