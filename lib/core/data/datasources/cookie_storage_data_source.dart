import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class CookieStorageDataSource {
  Future<String> saveCookiesToNetscape(List<dynamic> cookies);
  Future<String?> getCookiePath();
}

class CookieStorageDataSourceImpl implements CookieStorageDataSource {
  @override
  Future<String> saveCookiesToNetscape(List<dynamic> cookies) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/instagram_cookies.txt');
    
    final buffer = StringBuffer();
    buffer.writeln('# Netscape HTTP Cookie File');
    buffer.writeln('# http://curl.haxx.se/rfc/cookie_spec.html');
    buffer.writeln('# This is a generated file!  Do not edit.');
    buffer.writeln('');

    for (var cookie in cookies) {
      // Netscape format: domain, isDomain(flag), path, isSecure(flag), expiration, name, value
      // WebViewCookie has: name, value, domain, path
      final domain = cookie.domain;
      final name = cookie.name;
      final value = cookie.value;
      final path = cookie.path;
      
      // Defaulting some values as WebViewCookie is limited
      final isDomain = domain.startsWith('.') ? 'TRUE' : 'FALSE';
      const isSecure = 'TRUE';
      final expiration = (DateTime.now().add(const Duration(days: 30)).millisecondsSinceEpoch ~/ 1000).toString();

      buffer.writeln('$domain\t$isDomain\t$path\t$isSecure\t$expiration\t$name\t$value');
    }

    await file.writeAsString(buffer.toString());
    return file.path;
  }

  @override
  Future<String?> getCookiePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/instagram_cookies.txt');
    if (await file.exists()) {
      return file.path;
    }
    return null;
  }
}
