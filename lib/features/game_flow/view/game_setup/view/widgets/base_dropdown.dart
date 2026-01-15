import 'package:flutter/material.dart';
import 'package:guess_song/ui/theme/theme.dart';
import 'package:guess_song/utils/extensions/extensions.dart';

class BaseDropdown<T> extends StatelessWidget {
  const BaseDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged
  });

  final String label;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: DropdownButtonFormField<T>(
            value: value,
            items: items,
            onChanged: onChanged,
            icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).borderColor),
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          ),
        ),
      ],
    );
  }
}
