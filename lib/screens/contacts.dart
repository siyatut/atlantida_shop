import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart'; 

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme(
        data: Theme.of(context).copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mint,
              foregroundColor: AppColors.ink,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.black.withValues(alpha: .1),
            ),
          ),
        ),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: () => launchUrl(Uri.parse('tel:+79625046096')),
              icon: const Icon(Icons.call),
              label: const Text('Позвонить'),
            ),
            ElevatedButton.icon(
              onPressed: () => launchUrl(Uri.parse('mailto:gagin645@yandex.ru')),
              icon: const Icon(Icons.email_outlined),
              label: const Text('Написать'),
            ),
          ],
        ),
      ),
    );
  }
}
