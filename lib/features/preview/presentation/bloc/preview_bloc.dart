import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'preview_event.dart';
import 'preview_state.dart';
import '../../../home/domain/usecases/download_video.dart';
import '../../../history/domain/usecases/save_history.dart';
import '../../../history/domain/entities/download_record.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  final DownloadVideo downloadVideo;
  final SaveHistory saveHistory;

  PreviewBloc({
    required this.downloadVideo,
    required this.saveHistory,
  }) : super(PreviewInitial()) {
    on<StartDownload>(_onStartDownload);
  }

  Future<void> _onStartDownload(StartDownload event, Emitter<PreviewState> emit) async {
    // Request permissions
    if (Platform.isAndroid) {
      final status = await Permission.videos.request();
      if (!status.isGranted) {
        emit(const DownloadFailed('Storage permission denied'));
        return;
      }
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'grabit_${DateTime.now().millisecondsSinceEpoch}.${event.videoInfo.extension}';
    final savePath = '${directory.path}/$fileName';

    try {
      await emit.forEach(
        downloadVideo(event.videoInfo, savePath),
        onData: (double progress) => Downloading(progress),
        onError: (error, stackTrace) => DownloadFailed(error.toString()),
      );

      final file = File(savePath);
      if (await file.exists()) {
        final size = await file.length();

        // Save to gallery
        await Gal.putVideo(savePath);

        final record = DownloadRecord(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: event.videoInfo.title,
          platform: event.videoInfo.platform,
          localFilePath: savePath,
          thumbnailUrl: event.videoInfo.thumbnailUrl,
          fileSizeBytes: size,
          downloadedAt: DateTime.now(),
        );

        await saveHistory(record);
        emit(DownloadComplete(savePath));
      } else {
        emit(const DownloadFailed('Downloaded file not found'));
      }
    } catch (e) {
      emit(DownloadFailed(e.toString()));
    }
  }
}
