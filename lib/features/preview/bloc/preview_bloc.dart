import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:gal/gal.dart';
import '../../../domain/entities/video_info.dart';
import '../../../domain/entities/download_record.dart';
import '../../../domain/use_cases/download_video.dart';
import '../../../domain/repositories/download_repository.dart';
import '../../../domain/repositories/history_repository.dart';
import '../../../domain/repositories/settings_repository.dart';

part 'preview_event.dart';
part 'preview_state.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  final DownloadVideo downloadVideo;
  final DownloadRepository downloadRepository;
  final HistoryRepository historyRepository;
  final SettingsRepository settingsRepository;

  PreviewBloc({
    required this.downloadVideo,
    required this.downloadRepository,
    required this.historyRepository,
    required this.settingsRepository,
  }) : super(PreviewInitial()) {
    on<DownloadRequested>((event, emit) async {
      emit(Downloading(0));
      try {
        final savePath = await downloadRepository.getDownloadPath(event.videoInfo);
        
        await for (final progress in downloadVideo(event.videoInfo, savePath)) {
          emit(Downloading(progress));
        }

        final settings = await settingsRepository.getSettings();
        if (settings.autoSaveToGallery) {
          await Gal.putVideo(savePath);
        }

        final record = DownloadRecord(
          id: const Uuid().v4(),
          title: event.videoInfo.title,
          platform: event.videoInfo.platform,
          localFilePath: savePath,
          thumbnailUrl: event.videoInfo.thumbnailUrl,
          fileSizeBytes: 0, // Could be fetched from file
          downloadedAt: DateTime.now(),
        );

        await historyRepository.saveRecord(record);
        emit(DownloadComplete(savePath));
      } catch (e) {
        emit(DownloadFailed(e.toString()));
      }
    });
  }
}
