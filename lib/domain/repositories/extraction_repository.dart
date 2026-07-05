import '../entities/video_info.dart';

abstract class ExtractionRepository {
  Future<VideoInfo> extractVideoInfo(String url, {String? cookiePath});
  PlatformType detectPlatform(String url);
}
