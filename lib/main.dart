import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/catalog.dart';
import 'screens/about.dart';
import 'screens/contacts.dart';

void main() => runApp(const AtlantidaApp());

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
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        scaffoldBackgroundColor: const Color(0xFF061A2E),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: const _RootTabs(),
    );
  }
}

class _RootTabs extends StatefulWidget {
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
          title: Text(
            switch (_index) {
              0 => 'Главная',
              1 => 'Каталог',
              2 => 'О нас',
              _ => 'Контакты',
            },
          ),
        ),
        body: IndexedStack(index: _index, children: _pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Главная'),
            NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Каталог'),
            NavigationDestination(icon: Icon(Icons.info_outline), label: 'О нас'),
            NavigationDestination(icon: Icon(Icons.call_outlined), label: 'Контакты'),
          ],
        ),
      ),
    );
  }
}
