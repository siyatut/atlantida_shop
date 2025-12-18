import 'package:flutter/material.dart';

EdgeInsets tabScrollPadding(BuildContext context) {
  final bottomInset = MediaQuery.of(context).padding.bottom;
  return EdgeInsets.fromLTRB(16, 0, 16, bottomInset + 32);
}
