import '../entities/video_info.dart';

abstract class DownloadRepository {
  Stream<double> downloadVideo(VideoInfo videoInfo, String savePath);
  Future<String> getDownloadPath(VideoInfo videoInfo);
}
