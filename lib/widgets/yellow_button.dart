import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  const YellowButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
  });

  final String text;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
          Text(text, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
