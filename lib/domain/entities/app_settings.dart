import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final bool autoSaveToGallery;
  final String? downloadLocation;

  const AppSettings({
    required this.autoSaveToGallery,
    this.downloadLocation,
  });

  @override
  List<Object?> get props => [autoSaveToGallery, downloadLocation];

  AppSettings copyWith({
    bool? autoSaveToGallery,
    String? downloadLocation,
  }) {
    return AppSettings(
      autoSaveToGallery: autoSaveToGallery ?? this.autoSaveToGallery,
      downloadLocation: downloadLocation ?? this.downloadLocation,
    );
  }
}
