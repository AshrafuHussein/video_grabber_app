import 'package:flutter/services.dart';

abstract class ExtractionPlatformDataSource {
  Future<Map<String, dynamic>> extract(String url, {String? cookiePath});
}

class ExtractionPlatformDataSourceImpl implements ExtractionPlatformDataSource {
  static const _channel = MethodChannel('com.ashtek.grabit/extractor');

  @override
  Future<Map<String, dynamic>> extract(String url, {String? cookiePath}) async {
    try {
      final result = await _channel.invokeMethod<Map>('extract', {
        'url': url,
        'cookiePath': cookiePath,
      });
      return Map<String, dynamic>.from(result!);
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'Unknown extraction error');
    }
  }
}
