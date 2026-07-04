import '../entities/video_info.dart';

abstract class ExtractionRepository {
  Future<VideoInfo> extract(String url, {String? cookiePath});
  PlatformType detectPlatform(String url);
}
