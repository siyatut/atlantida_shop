import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:atlantida_shop/core/env.dart';
import 'theme/app_colors.dart';

import 'screens/home.dart';
import 'screens/catalog.dart';
import 'screens/about.dart';
import 'screens/contacts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  runApp(const AtlantidaApp());
}

class AtlantidaApp extends StatelessWidget {
  const AtlantidaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightAqua = ColorScheme.fromSeed(seedColor: AppColors.aqua);

    return MaterialApp(
      title: 'Атлантида',
      debugShowCheckedModeBanner: false,
      // Глобальная тема (бары прозрачные, фон зададим в builder)
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightAqua,
        scaffoldBackgroundColor: Colors.transparent,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark, // тёмные иконки в статус-баре
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.ink,
          ),
        ),

        navigationBarTheme: NavigationBarThemeData(
          height: 72,
          elevation: 0,
          backgroundColor: Colors.transparent,            // низ прозрачен — под ним тот же градиент
          surfaceTintColor: Colors.transparent,
          indicatorColor: AppColors.aqua.withValues(alpha: .18), // мягкая подсветка активного
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              size: 26,
              color: states.contains(WidgetState.selected)
                  ? AppColors.ink        // выбранный — тёмный
                  : Colors.white,        // невыбранный — белый
            ),
          ),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w700
                  : FontWeight.w600,
              color: states.contains(WidgetState.selected)
                  ? AppColors.ink
                  : Colors.white,
            ),
          ),
        ),
      ),

      // ЕДИНЫЙ ФОН: градиент тянется от самого верха до самого низа
      builder: (context, child) => DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.gradientAqua),
        child: child ?? const SizedBox.shrink(),
      ),

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
        // важные флаги: фон тянется и под верх/низ
        extendBody: true,
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          title: Text(
            switch (_index) {
              0 => 'Главная',
              1 => 'Каталог',
              2 => 'О нас',
              _ => 'Контакты',
            },
          ),
          // Очень мягкая разделительная линия снизу (если не нужна — убери блок bottom)
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(
              height: 0.5,
              color: Colors.white.withValues(alpha: .12),
            ),
          ),
        ),

        body: IndexedStack(index: _index, children: _pages),

        bottomNavigationBar: SafeArea(
          top: false,
          child: NavigationBar(
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
      ),
    );
  }
}
