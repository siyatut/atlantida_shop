import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}

Future<void> sendEmail({
  required String email,
  String? subject,
  String? body,
}) async {
  final Uri uri = Uri(
    scheme: 'mailto',
    path: email,
    query: _encodeQueryParameters({
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
    }),
  );

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not send email to $email';
  }
}

String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
