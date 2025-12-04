import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AquaScaffold extends StatelessWidget {
  const AquaScaffold({
    super.key,
    required this.body,
    this.useDark = false,
    this.appBar,
    this.bottomNavigationBar,
  });

  final Widget body;
  final bool useDark; // если true — Ocean градиент
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final gradient = isDark ? AppColors.gradientOcean : AppColors.gradientAqua;

    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
