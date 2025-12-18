import 'package:flutter/material.dart';

import 'core/env.dart';
import 'theme/app_theme.dart';
import 'app/app_background.dart';
import 'app/root_tabs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  runApp(const AtlantidaApp());
}

class AtlantidaApp extends StatelessWidget {
  const AtlantidaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Атлантида',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      builder: (context, child) =>
          AppBackground(child: child ?? const SizedBox.shrink()),
      home: const RootTabs(),
    );
  }
}
