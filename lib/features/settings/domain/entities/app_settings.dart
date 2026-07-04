import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final bool autoSaveToGallery;
  final String downloadLocation;

  const AppSettings({
    required this.autoSaveToGallery,
    required this.downloadLocation,
  });

  @override
  List<Object?> get props => [autoSaveToGallery, downloadLocation];
}
