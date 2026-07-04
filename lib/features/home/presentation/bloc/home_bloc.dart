import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../domain/usecases/extract_video_info.dart';
import '../../domain/usecases/detect_platform.dart';
import '../../domain/entities/video_info.dart';
import '../../../history/domain/usecases/get_history.dart'; // I should create this use case
import '../../../../core/domain/repositories/cookie_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ExtractVideoInfo extractVideoInfo;
  final DetectPlatform detectPlatform;
  final GetHistory getHistory;
  final CookieRepository cookieRepository;

  HomeBloc({
    required this.extractVideoInfo,
    required this.detectPlatform,
    required this.getHistory,
    required this.cookieRepository,
  }) : super(HomeInitial()) {
    on<FetchRecentDownloads>(_onFetchRecentDownloads);
    on<ExtractRequested>(_onExtractRequested);
  }

  Future<void> _onFetchRecentDownloads(FetchRecentDownloads event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final history = await getHistory();
      emit(HomeHistoryLoaded(history.take(5).toList()));
    } catch (e) {
      emit(ExtractionFailure(e.toString()));
    }
  }

  Future<void> _onExtractRequested(ExtractRequested event, Emitter<HomeState> emit) async {
    final platform = detectPlatform(event.url);
    if (platform == PlatformType.unknown) {
      emit(UnsupportedPlatform(event.url));
      return;
    }

    emit(ExtractionLoading());

    String? cookiePath;
    if (platform == PlatformType.instagram) {
      cookiePath = await cookieRepository.getInstagramCookiePath();
      if (cookiePath == null) {
        emit(NeedsInstagramAuth(event.url));
        return;
      }
    }

    try {
      final videoInfo = await extractVideoInfo(event.url, cookiePath: cookiePath);
      emit(ExtractionSuccess(videoInfo));
    } catch (e) {
      emit(ExtractionFailure(e.toString()));
    }
  }
}
