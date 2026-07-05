import '../entities/video_info.dart';
import '../repositories/download_repository.dart';

class DownloadVideo {
  final DownloadRepository repository;

  DownloadVideo(this.repository);

  Stream<double> call(VideoInfo videoInfo, String savePath) {
    return repository.downloadVideo(videoInfo, savePath);
  }
}
