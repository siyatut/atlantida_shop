import 'package:flutter/material.dart';

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleMedium);
  }
}
