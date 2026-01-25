import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    super.key,
    required this.label,
    this.hint,
    this.enabled = true,
    required this.onChanged,
  });

  final String label;
  final String? hint;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        SizedBox(
          height: 50,
          child: TextField(
            enabled: enabled,
            decoration: InputDecoration(hintText: hint),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
