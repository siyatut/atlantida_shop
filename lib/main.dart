import 'package:atlantida_shop/core/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/about.dart';
import 'screens/catalog.dart';
import 'screens/contacts.dart';
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  runApp(const AtlantidaApp());
}

class AtlantidaApp extends StatelessWidget {
  const AtlantidaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF0E3A69);
    return MaterialApp(
      title: 'Атлантида',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF08233A),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFF08233A),
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light, 
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color(0xFF08233A),
          indicatorColor: Color(0xFF0E3A69), // мягкий подсвет индикатора
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const _RootTabs(),
    );
  }
}

class _RootTabs extends StatefulWidget {
  // ignore: unused_element_parameter
  const _RootTabs({super.key});
  @override
  State<_RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<_RootTabs> {
  int _index = 0;

  final _pages = const [
    HomeScreen(),
    CatalogScreen(),
    AboutScreen(),
    ContactsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(switch (_index) {
            0 => 'Главная',
            1 => 'Каталог',
            2 => 'О нас',
            _ => 'Контакты',
          }),
        ),
        body: IndexedStack(index: _index, children: _pages),
        bottomNavigationBar: NavigationBar(
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
    );
  }
}
