import '../entities/video_info.dart';
import '../repositories/extraction_repository.dart';

class DetectPlatform {
  final ExtractionRepository repository;

  DetectPlatform(this.repository);

  PlatformType call(String url) {
    return repository.detectPlatform(url);
  }
}
