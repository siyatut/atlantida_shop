import 'core/env.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'screens/about.dart';
import 'screens/catalog.dart';
import 'screens/contacts.dart';
import 'screens/home.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';

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
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: isDark ? AppColors.gradientOcean : AppColors.gradientAqua,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },

      home: const _RootTabs(),
    );
  }
}

class _RootTabs extends StatefulWidget {
  const _RootTabs();

  @override
  State<_RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<_RootTabs> {
  int _index = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomeScreen(onOpenCatalog: () => setState(() => _index = 1)),
      const CatalogScreen(),
      const AboutScreen(),
      const ContactsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Text(switch (_index) {
            0 => 'Главная',
            1 => 'Каталог',
            2 => 'О нас',
            _ => 'Контакты',
          }),
        ),
        body: IndexedStack(index: _index, children: _pages),
        bottomNavigationBar: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Главная',
              ),
              NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                label: 'Каталог',
              ),
              NavigationDestination(
                icon: Icon(Icons.info_outline),
                label: 'О нас',
              ),
              NavigationDestination(
                icon: Icon(Icons.call_outlined),
                label: 'Контакты',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
