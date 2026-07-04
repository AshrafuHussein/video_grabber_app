import '../../domain/entities/video_info.dart';
import '../../domain/repositories/extraction_repository.dart';
import '../datasources/extraction_platform_data_source.dart';

class ExtractionRepositoryImpl implements ExtractionRepository {
  final ExtractionPlatformDataSource dataSource;

  ExtractionRepositoryImpl(this.dataSource);

  @override
  Future<VideoInfo> extract(String url, {String? cookiePath}) async {
    final map = await dataSource.extract(url, cookiePath: cookiePath);
    
    if (map.containsKey('error')) {
      throw Exception(map['error']);
    }

    return VideoInfo(
      title: map['title'] ?? 'Video',
      thumbnailUrl: map['thumbnail'] ?? '',
      directUrl: map['direct_url'] ?? '',
      extension: map['ext'] ?? 'mp4',
      durationSeconds: double.tryParse(map['duration']?.toString() ?? '0') ?? 0,
      platform: _mapPlatform(map['platform']?.toString()),
    );
  }

  @override
  PlatformType detectPlatform(String url) {
    if (url.contains('tiktok.com')) return PlatformType.tiktok;
    if (url.contains('instagram.com')) return PlatformType.instagram;
    if (url.contains('twitter.com') || url.contains('x.com')) return PlatformType.x;
    return PlatformType.unknown;
  }

  PlatformType _mapPlatform(String? platform) {
    switch (platform) {
      case 'tiktok': return PlatformType.tiktok;
      case 'instagram': return PlatformType.instagram;
      case 'x': return PlatformType.x;
      default: return PlatformType.unknown;
    }
  }
}
