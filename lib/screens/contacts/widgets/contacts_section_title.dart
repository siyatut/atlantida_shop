import 'package:flutter/material.dart';

class ContactsSectionTitle extends StatelessWidget {
  const ContactsSectionTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      text,
      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
    );
  }
}
