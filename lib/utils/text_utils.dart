
String splitTitleInTwo(String title) {
  final t = title.trim().replaceAll(RegExp(r'\s+'), ' ');
  final words = t.split(' ');
  if (words.length <= 1) return t;

  final totalLen = t.length;
  int bestIndex = 1;
  double bestDiff = double.infinity;

  for (int i = 1; i < words.length; i++) {
    final left = words.sublist(0, i).join(' ');
    final diff = (totalLen / 2 - left.length).abs(); // diff = double
    if (diff < bestDiff) {
      bestDiff = diff;
      bestIndex = i;
    }
  }

  final line1 = words.sublist(0, bestIndex).join(' ');
  final line2 = words.sublist(bestIndex).join(' ');
  return '$line1\n$line2';
}
