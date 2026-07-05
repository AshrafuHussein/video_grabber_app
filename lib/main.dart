import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/utils/share_intent_handler.dart';

// Data Sources
import 'data/data_sources/extraction_platform_data_source.dart';
import 'data/data_sources/video_download_data_source.dart';
import 'data/data_sources/history_local_data_source.dart';
import 'data/data_sources/settings_local_data_source.dart';
import 'data/data_sources/cookie_storage_data_source.dart';

// Models
import 'data/models/download_record_model.dart';

// Repositories
import 'data/repositories/extraction_repository_impl.dart';
import 'data/repositories/download_repository_impl.dart';
import 'data/repositories/history_repository_impl.dart';
import 'data/repositories/settings_repository_impl.dart';

// Use Cases
import 'domain/use_cases/extract_video_info.dart';
import 'domain/use_cases/detect_platform.dart';
import 'domain/use_cases/download_video.dart';

// Blocs
import 'features/home/bloc/extraction_bloc.dart';
import 'features/preview/bloc/preview_bloc.dart';
import 'features/history/bloc/history_bloc.dart';
import 'features/settings/bloc/settings_bloc.dart';
import 'features/instagram_auth/bloc/instagram_auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(DownloadRecordModelAdapter());
  
  final dio = Dio();
  
  // Data Sources
  final extractionDS = ExtractionPlatformDataSourceImpl();
  final downloadDS = VideoDownloadDataSourceImpl(dio);
  final historyDS = HistoryLocalDataSourceImpl();
  final settingsDS = SettingsLocalDataSourceImpl();
  final cookieDS = CookieStorageDataSourceImpl();
  
  // Repositories
  final extractionRepo = ExtractionRepositoryImpl(extractionDS);
  final downloadRepo = DownloadRepositoryImpl(downloadDS);
  final historyRepo = HistoryRepositoryImpl(historyDS);
  final settingsRepo = SettingsRepositoryImpl(settingsDS);

  runApp(
    GrabItApp(
      extractionRepo: extractionRepo,
      downloadRepo: downloadRepo,
      historyRepo: historyRepo,
      settingsRepo: settingsRepo,
      cookieStorage: cookieDS,
    ),
  );
}

class GrabItApp extends StatelessWidget {
  final ExtractionRepositoryImpl extractionRepo;
  final DownloadRepositoryImpl downloadRepo;
  final HistoryRepositoryImpl historyRepo;
  final SettingsRepositoryImpl settingsRepo;
  final CookieStorageDataSource cookieStorage;

  const GrabItApp({
    super.key,
    required this.extractionRepo,
    required this.downloadRepo,
    required this.historyRepo,
    required this.settingsRepo,
    required this.cookieStorage,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bloc = ExtractionBloc(
              extractVideoInfo: ExtractVideoInfo(extractionRepo),
              detectPlatform: DetectPlatform(extractionRepo),
              cookieStorage: cookieStorage,
            );
            // Initialize Share Intent Handler
            ShareIntentHandler(bloc).init();
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) => PreviewBloc(
            downloadVideo: DownloadVideo(downloadRepo),
            downloadRepository: downloadRepo,
            historyRepository: historyRepo,
            settingsRepository: settingsRepo,
          ),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(
            repository: historyRepo,
          )..add(HistoryRequested()),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(
            repository: settingsRepo,
          )..add(SettingsRequested()),
        ),
        BlocProvider(
          create: (context) => InstagramAuthBloc(
            cookieStorage: cookieStorage,
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'GrabIt',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
