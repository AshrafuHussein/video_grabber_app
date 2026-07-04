import '../../domain/entities/video_info.dart';
import '../../domain/repositories/download_repository.dart';
import '../datasources/video_download_data_source.dart';

class DownloadRepositoryImpl implements DownloadRepository {
  final VideoDownloadDataSource dataSource;

  DownloadRepositoryImpl(this.dataSource);

  @override
  Stream<double> downloadVideo(VideoInfo videoInfo, String savePath) {
    return dataSource.downloadVideo(videoInfo.directUrl, savePath);
  }
}
