import '../../domain/entities/video_info.dart';
import '../../domain/repositories/extraction_repository.dart';
import '../data_sources/extraction_platform_data_source.dart';

class ExtractionRepositoryImpl implements ExtractionRepository {
  final ExtractionPlatformDataSource dataSource;

  ExtractionRepositoryImpl(this.dataSource);

  @override
  Future<VideoInfo> extractVideoInfo(String url, {String? cookiePath}) async {
    final data = await dataSource.extract(url, cookiePath: cookiePath);
    
    return VideoInfo(
      title: data['title'] ?? 'No Title',
      thumbnailUrl: data['thumbnail'],
      directUrl: data['direct_url'] ?? '',
      extension: data['ext'],
      durationSeconds: double.tryParse(data['duration']?.toString() ?? '')?.toInt(),
      platform: _mapPlatform(data['platform']),
      httpHeaders: Map<String, String>.from(data['http_headers'] ?? {}),
    );
  }

  @override
  PlatformType detectPlatform(String url) {
    if (url.contains('tiktok.com')) return PlatformType.tiktok;
    if (url.contains('instagram.com')) return PlatformType.instagram;
    if (url.contains('twitter.com') || url.contains('x.com')) return PlatformType.twitter;
    return PlatformType.unknown;
  }

  PlatformType _mapPlatform(String? platform) {
    switch (platform) {
      case 'tiktok':
        return PlatformType.tiktok;
      case 'instagram':
        return PlatformType.instagram;
      case 'twitter':
        return PlatformType.twitter;
      default:
        return PlatformType.unknown;
    }
  }
}
