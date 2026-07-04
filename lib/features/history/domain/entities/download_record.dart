import 'package:equatable/equatable.dart';
import 'package:video_grabber_app/features/home/domain/entities/video_info.dart';

class DownloadRecord extends Equatable {
  final String id;
  final String title;
  final PlatformType platform;
  final String localFilePath;
  final String thumbnailUrl;
  final int fileSizeBytes;
  final DateTime downloadedAt;

  const DownloadRecord({
    required this.id,
    required this.title,
    required this.platform,
    required this.localFilePath,
    required this.thumbnailUrl,
    required this.fileSizeBytes,
    required this.downloadedAt,
  });

  @override
  List<Object?> get props => [id, title, platform, localFilePath, thumbnailUrl, fileSizeBytes, downloadedAt];
}
