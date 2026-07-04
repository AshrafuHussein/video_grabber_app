import '../entities/video_info.dart';
import '../repositories/extraction_repository.dart';

class ExtractVideoInfo {
  final ExtractionRepository repository;

  ExtractVideoInfo(this.repository);

  Future<VideoInfo> call(String url, {String? cookiePath}) {
    return repository.extract(url, cookiePath: cookiePath);
  }
}
