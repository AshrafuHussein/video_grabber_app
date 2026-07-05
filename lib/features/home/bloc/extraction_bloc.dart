import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/video_info.dart';
import '../../../domain/use_cases/extract_video_info.dart';
import '../../../domain/use_cases/detect_platform.dart';
import '../../../data/data_sources/cookie_storage_data_source.dart';

part 'extraction_event.dart';
part 'extraction_state.dart';

class ExtractionBloc extends Bloc<ExtractionEvent, ExtractionState> {
  final ExtractVideoInfo extractVideoInfo;
  final DetectPlatform detectPlatform;
  final CookieStorageDataSource cookieStorage;

  ExtractionBloc({
    required this.extractVideoInfo,
    required this.detectPlatform,
    required this.cookieStorage,
  }) : super(ExtractionInitial()) {
    on<LinkPasted>((event, emit) async {
      final platform = detectPlatform(event.url);
      if (platform == PlatformType.unknown) {
        emit(const UnsupportedPlatform('Unsupported URL format'));
        return;
      }
      
      emit(ExtractionLoading());
      try {
        String? cookiePath;
        if (platform == PlatformType.instagram) {
          cookiePath = await cookieStorage.getCookiePath();
          if (cookiePath == null) {
            emit(InstagramAuthRequired());
            return;
          }
        }

        final videoInfo = await extractVideoInfo(event.url, cookiePath: cookiePath);
        emit(ExtractionSuccess(videoInfo));
      } catch (e) {
        emit(ExtractionFailure(e.toString()));
      }
    });
  }
}
