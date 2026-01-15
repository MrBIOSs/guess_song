import 'package:flutter/material.dart';
import 'package:guess_song/utils/extensions/theme.dart';

class BaseOutlinedButton extends StatelessWidget {
  const BaseOutlinedButton({super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
          backgroundColor: Theme.of(context).fillColor,
          side: BorderSide(
            color: Theme.of(context).borderColor,
          ),
        ),
      ),
    );
  }
}
