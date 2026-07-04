import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const String keyAutoSave = 'auto_save_gallery';
  static const String keyDownloadLocation = 'download_location';

  @override
  Future<AppSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return AppSettings(
      autoSaveToGallery: prefs.getBool(keyAutoSave) ?? true,
      downloadLocation: prefs.getString(keyDownloadLocation) ?? '',
    );
  }

  @override
  Future<void> updateSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyAutoSave, settings.autoSaveToGallery);
    await prefs.setString(keyDownloadLocation, settings.downloadLocation);
  }
}
