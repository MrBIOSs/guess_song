import 'package:flutter/material.dart';
import '../../../../../../ui/theme/theme.dart';

class BaseDropdown<T> extends StatelessWidget {
  const BaseDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    this.enabled = true,
    required this.onChanged
  });

  final String label;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final bool enabled;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        SizedBox(
          height: 50,
          child: DropdownButtonFormField<T>(
            value: value,
            items: items,
            onChanged: enabled ? onChanged : null,
            icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).borderColor),
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
