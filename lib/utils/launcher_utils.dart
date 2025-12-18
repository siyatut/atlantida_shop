import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final uri = Uri(scheme: 'tel', path: phoneNumber);
  await _launchExternal(uri, error: 'Could not launch $phoneNumber');
}

Future<void> sendEmail({
  required String email,
  String? subject,
  String? body,
}) async {
  final uri = Uri(
    scheme: 'mailto',
    path: email,
    query: _encodeQueryParameters({
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
    }),
  );

  await _launchExternal(uri, error: 'Could not send email to $email');
}

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  await _launchExternal(uri, error: 'Could not open $url');
}

Future<void> _launchExternal(Uri uri, {required String error}) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw Exception(error);
  }
}

String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
