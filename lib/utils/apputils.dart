stripText(i) {
  const start = '">';
  const end = '</a>';
  var str = i;

  final startIndex = str.indexOf(start);
  final endIndex = str.indexOf(end);
  final result = str.substring(startIndex + start.length, endIndex).trim();
  return result;
}

stripUrl(String data) {
  final urlRegExp = new RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
  final urlMatches = urlRegExp.allMatches(data);
  List urls = urlMatches
      .map((urlMatch) => data.substring(urlMatch.start, urlMatch.end))
      .toList();
  return urls;
}

loadAvatar(String url) {
  List<String> l = stripUrl(url);

  if (l.length > 0) {
    return l[0];
  } else {
    return 'https://lekbeshimun.gov.np/sites/lekbeshimun.gov.np/files/default.png';
  }
}

contentLink(String link) {
  String urlPrefix = '<a href="';

  int urlStart = link.indexOf(urlPrefix) + urlPrefix.length;
  int urlEnd = link.indexOf('"', urlStart);

  return (link.substring(urlStart, urlEnd));
}
