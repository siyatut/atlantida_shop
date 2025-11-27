
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

String fixPrepositions(String text) {
  final preps = [
    'в','к','с','у','о','а','я','и','но','на','по','за','из','от','до',
    'без','при','над','под','про','для','об','обо','со','ко','во'
  ];

  final pattern = RegExp(
    r'(^|[\s\n])(' + preps.join('|') + r')\s+(?=\S)',
    caseSensitive: false,
  );

  return text.replaceAllMapped(pattern, (m) {
    final leftSpace = m.group(1)!;   // пробел/начало строки
    final prep = m.group(2)!;        // сам предлог
    return '$leftSpace$prep\u00A0';  // NBSP после предлога
  });
}