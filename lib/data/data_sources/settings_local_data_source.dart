import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<bool> getAutoSaveToGallery();
  Future<void> setAutoSaveToGallery(bool value);
  Future<String?> getDownloadLocation();
  Future<void> setDownloadLocation(String path);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const _autoSaveKey = 'auto_save_to_gallery';
  static const _downloadLocationKey = 'download_location';

  @override
  Future<bool> getAutoSaveToGallery() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoSaveKey) ?? true;
  }

  @override
  Future<void> setAutoSaveToGallery(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoSaveKey, value);
  }

  @override
  Future<String?> getDownloadLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_downloadLocationKey);
  }

  @override
  Future<void> setDownloadLocation(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_downloadLocationKey, path);
  }
}
