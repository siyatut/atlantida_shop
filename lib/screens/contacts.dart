import 'package:flutter/material.dart';
import '../utils/launcher_utils.dart';
import '../widgets/yellow_button.dart';
import '../core/app_contacts.dart';


class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 160,
              child: YellowButton(
                text: 'Позвонить',
                icon: Icons.call,
                onTap: () => makePhoneCall(AppContacts.phone),
              ),
            ),
            SizedBox(
              width: 160,
              child: YellowButton(
                text: 'Написать',
                icon: Icons.email_outlined,
                onTap: () => sendEmail(
                  email: AppContacts.email,
                  subject: 'Вопрос из приложения',
                  body: 'Здравствуйте! Хочу уточнить детали…',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
