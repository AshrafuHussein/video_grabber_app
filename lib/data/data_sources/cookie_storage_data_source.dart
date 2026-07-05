import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class CookieStorageDataSource {
  Future<String> saveCookies(String content);
  Future<String?> getCookiePath();
}

class CookieStorageDataSourceImpl implements CookieStorageDataSource {
  static const _fileName = 'instagram_cookies.txt';

  @override
  Future<String> saveCookies(String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_fileName');
    await file.writeAsString(content);
    return file.path;
  }

  @override
  Future<String?> getCookiePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_fileName');
    if (await file.exists()) {
      return file.path;
    }
    return null;
  }
}
