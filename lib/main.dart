import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/utils/share_intent_handler.dart';
import 'features/home/data/datasources/extraction_platform_data_source.dart';
import 'features/home/data/datasources/video_download_data_source.dart';
import 'features/home/data/repositories/extraction_repository_impl.dart';
import 'features/home/data/repositories/download_repository_impl.dart';
import 'features/home/domain/usecases/extract_video_info.dart';
import 'features/home/domain/usecases/detect_platform.dart';
import 'features/home/domain/usecases/download_video.dart';
import 'features/history/data/repositories/history_repository_impl.dart';
import 'features/history/data/models/download_record_model.dart';
import 'features/history/domain/usecases/get_history.dart';
import 'features/history/domain/usecases/save_history.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'core/data/datasources/cookie_storage_data_source.dart';
import 'core/data/repositories/cookie_repository_impl.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/bloc/home_event.dart';
import 'features/preview/presentation/bloc/preview_bloc.dart';
import 'features/history/presentation/bloc/history_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/instagram_auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(DownloadRecordModelAdapter());
  
  final dio = Dio();
  
  // Data Sources
  final extractionDS = ExtractionPlatformDataSourceImpl();
  final downloadDS = VideoDownloadDataSourceImpl(dio);
  final cookieDS = CookieStorageDataSourceImpl();
  
  // Repositories
  final extractionRepo = ExtractionRepositoryImpl(extractionDS);
  final downloadRepo = DownloadRepositoryImpl(downloadDS);
  final historyRepo = HistoryRepositoryImpl();
  final settingsRepo = SettingsRepositoryImpl();
  final cookieRepo = CookieRepositoryImpl(cookieDS);

  runApp(
    GrabItApp(
      extractionRepo: extractionRepo,
      downloadRepo: downloadRepo,
      historyRepo: historyRepo,
      settingsRepo: settingsRepo,
      cookieRepo: cookieRepo,
    ),
  );
}

class GrabItApp extends StatefulWidget {
  final ExtractionRepositoryImpl extractionRepo;
  final DownloadRepositoryImpl downloadRepo;
  final HistoryRepositoryImpl historyRepo;
  final SettingsRepositoryImpl settingsRepo;
  final CookieRepositoryImpl cookieRepo;

  const GrabItApp({
    super.key,
    required this.extractionRepo,
    required this.downloadRepo,
    required this.historyRepo,
    required this.settingsRepo,
    required this.cookieRepo,
  });

  @override
  State<GrabItApp> createState() => _GrabItAppState();
}

class _GrabItAppState extends State<GrabItApp> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(
      extractVideoInfo: ExtractVideoInfo(widget.extractionRepo),
      detectPlatform: DetectPlatform(widget.extractionRepo),
      getHistory: GetHistory(widget.historyRepo),
      cookieRepository: widget.cookieRepo,
    );

    // Initialize Share Intent Handler
    ShareIntentHandler.init(onUrlReceived: (url) {
      _homeBloc.add(ExtractRequested(url));
    });
  }

  @override
  void dispose() {
    ShareIntentHandler.dispose();
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.extractionRepo),
        RepositoryProvider.value(value: widget.downloadRepo),
        RepositoryProvider.value(value: widget.historyRepo),
        RepositoryProvider.value(value: widget.settingsRepo),
        RepositoryProvider.value(value: widget.cookieRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _homeBloc),
          BlocProvider(
            create: (context) => PreviewBloc(
              downloadVideo: DownloadVideo(widget.downloadRepo),
              saveHistory: SaveHistory(widget.historyRepo),
            ),
          ),
          BlocProvider(
            create: (context) => HistoryBloc(
              getHistory: GetHistory(widget.historyRepo),
              repository: widget.historyRepo,
            ),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(widget.settingsRepo),
          ),
          BlocProvider(
            create: (context) => InstagramAuthBloc(widget.cookieRepo),
          ),
        ],
        child: MaterialApp.router(
          title: 'GrabIt',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
