import 'package:hive/hive.dart';
import '../../../home/domain/entities/video_info.dart';
import '../../domain/entities/download_record.dart';

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
  final String thumbnailUrl;
  @HiveField(5)
  final int fileSizeBytes;
  @HiveField(6)
  final DateTime downloadedAt;

  DownloadRecordModel({
    required this.id,
    required this.title,
    required this.platform,
    required this.localFilePath,
    required this.thumbnailUrl,
    required this.fileSizeBytes,
    required this.downloadedAt,
  });

  factory DownloadRecordModel.fromEntity(DownloadRecord record) {
    return DownloadRecordModel(
      id: record.id,
      title: record.title,
      platform: record.platform.name,
      localFilePath: record.localFilePath,
      thumbnailUrl: record.thumbnailUrl,
      fileSizeBytes: record.fileSizeBytes,
      downloadedAt: record.downloadedAt,
    );
  }

  DownloadRecord toEntity() {
    return DownloadRecord(
      id: id,
      title: title,
      platform: PlatformType.values.firstWhere((e) => e.name == platform, orElse: () => PlatformType.unknown),
      localFilePath: localFilePath,
      thumbnailUrl: thumbnailUrl,
      fileSizeBytes: fileSizeBytes,
      downloadedAt: downloadedAt,
    );
  }
}
