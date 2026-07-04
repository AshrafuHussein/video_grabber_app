import 'package:dio/dio.dart';
import 'dart:async';

abstract class VideoDownloadDataSource {
  Stream<double> downloadVideo(String url, String savePath);
}

class VideoDownloadDataSourceImpl implements VideoDownloadDataSource {
  final Dio dio;

  VideoDownloadDataSourceImpl(this.dio);

  @override
  Stream<double> downloadVideo(String url, String savePath) {
    final controller = StreamController<double>();
    
    dio.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          controller.add(received / total);
        }
      },
    ).then((_) {
      controller.close();
    }).catchError((e) {
      controller.addError(e);
      controller.close();
    });

    return controller.stream;
  }
}
