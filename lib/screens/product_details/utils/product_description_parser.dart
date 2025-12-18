String cleanProductDescription(String? html) {
  if (html == null || html.isEmpty) return '';

  var text = html;

  // Простые замены br → перенос строки
  text = text
      .replaceAll('<br />', '\n')
      .replaceAll('<br/>', '\n')
      .replaceAll('<br>', '\n');

  final buffer = StringBuffer();
  var i = 0;
  var consecutiveNewlines = 0;

  void writeWithNewlineCollapse(String s) {
    for (final codeUnit in s.codeUnits) {
      final ch = String.fromCharCode(codeUnit);
      if (ch == '\n') {
        if (consecutiveNewlines < 2) {
          buffer.write(ch);
        }
        consecutiveNewlines++;
      } else {
        consecutiveNewlines = 0;
        buffer.write(ch);
      }
    }
  }

  while (i < text.length) {
    final ch = text[i];

    if (ch == '<') {
      final close = text.indexOf('>', i + 1);
      if (close == -1) {
        writeWithNewlineCollapse(text.substring(i));
        break;
      }

      final rawTag = text.substring(i + 1, close).trim();
      final tag = rawTag.toLowerCase();

      if (tag.startsWith('/p')) {
        writeWithNewlineCollapse('\n\n');
      } else if (tag.startsWith('p')) {
        // <p ...> — ничего не пишем
      } else if (tag.startsWith('li')) {
        writeWithNewlineCollapse('• ');
      } else if (tag.startsWith('/li')) {
        writeWithNewlineCollapse('\n');
      } else if (tag.startsWith('ul') ||
          tag.startsWith('/ul') ||
          tag.startsWith('ol') ||
          tag.startsWith('/ol')) {
        // list-теги игнорируем
      } else {
        // остальные теги просто срезаем
      }

      i = close + 1;
    } else {
      final nextTag = text.indexOf('<', i);
      final end = nextTag == -1 ? text.length : nextTag;
      writeWithNewlineCollapse(text.substring(i, end));
      i = end;
    }
  }

  var result = buffer.toString();

  // HTML-сущности
  result = result
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'");

  return result.trim();
}
