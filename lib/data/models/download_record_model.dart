import 'package:hive/hive.dart';
import '../../domain/entities/download_record.dart';
import '../../domain/entities/video_info.dart';

part 'download_record_model.g.dart';

@HiveType(typeId: 0)
class DownloadRecordModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String platform;
  @HiveField(3)
  final String localFilePath;
  @HiveField(4)
  final String? thumbnailUrl;
  @HiveField(5)
  final int fileSizeBytes;
  @HiveField(6)
  final DateTime downloadedAt;

  DownloadRecordModel({
    required this.id,
    required this.title,
    required this.platform,
    required this.localFilePath,
    this.thumbnailUrl,
    required this.fileSizeBytes,
    required this.downloadedAt,
  });

  factory DownloadRecordModel.fromEntity(DownloadRecord entity) {
    return DownloadRecordModel(
      id: entity.id,
      title: entity.title,
      platform: entity.platform.name,
      localFilePath: entity.localFilePath,
      thumbnailUrl: entity.thumbnailUrl,
      fileSizeBytes: entity.fileSizeBytes,
      downloadedAt: entity.downloadedAt,
    );
  }

  DownloadRecord toEntity() {
    return DownloadRecord(
      id: id,
      title: title,
      platform: PlatformType.values.firstWhere(
        (e) => e.name == platform,
        orElse: () => PlatformType.unknown,
      ),
      localFilePath: localFilePath,
      thumbnailUrl: thumbnailUrl,
      fileSizeBytes: fileSizeBytes,
      downloadedAt: downloadedAt,
    );
  }
}
