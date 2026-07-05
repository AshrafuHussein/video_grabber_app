import 'package:path_provider/path_provider.dart';
import '../../domain/entities/video_info.dart';
import '../../domain/repositories/download_repository.dart';
import '../data_sources/video_download_data_source.dart';

class DownloadRepositoryImpl implements DownloadRepository {
  final VideoDownloadDataSource dataSource;

  DownloadRepositoryImpl(this.dataSource);

  @override
  Stream<double> downloadVideo(VideoInfo videoInfo, String savePath) {
    return dataSource.download(videoInfo.directUrl, savePath, videoInfo.httpHeaders);
  }

  @override
  Future<String> getDownloadPath(VideoInfo videoInfo) async {
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = videoInfo.extension ?? 'mp4';
    return '${directory.path}/video_$timestamp.$extension';
  }
}
