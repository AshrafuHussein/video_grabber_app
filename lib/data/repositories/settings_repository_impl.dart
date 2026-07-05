import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../data_sources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource dataSource;

  SettingsRepositoryImpl(this.dataSource);

  @override
  Future<AppSettings> getSettings() async {
    final autoSave = await dataSource.getAutoSaveToGallery();
    final location = await dataSource.getDownloadLocation();
    return AppSettings(autoSaveToGallery: autoSave, downloadLocation: location);
  }

  @override
  Future<void> updateSettings(AppSettings settings) async {
    await dataSource.setAutoSaveToGallery(settings.autoSaveToGallery);
    if (settings.downloadLocation != null) {
      await dataSource.setDownloadLocation(settings.downloadLocation!);
    }
  }
}
