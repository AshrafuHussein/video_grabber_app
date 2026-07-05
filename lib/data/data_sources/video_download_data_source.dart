import 'dart:async';
import 'package:dio/dio.dart';

abstract class VideoDownloadDataSource {
  Stream<double> download(String url, String savePath, Map<String, String> headers);
}

class VideoDownloadDataSourceImpl implements VideoDownloadDataSource {
  final Dio _dio;

  VideoDownloadDataSourceImpl(this._dio);

  @override
  Stream<double> download(String url, String savePath, Map<String, String> headers) {
    final controller = StreamController<double>();

    _dio.download(
      url,
      savePath,
      options: Options(headers: headers),
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
