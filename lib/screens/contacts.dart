import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
            onPressed: () => launchUrl(Uri.parse('mailto:rnti43@yandex.ru')),
            icon: const Icon(Icons.email_outlined),
            label: const Text('Написать'),
          ),
        ],
      ),
    );
  }
}

