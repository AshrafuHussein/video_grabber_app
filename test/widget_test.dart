// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:video_grabber_app/main.dart';
import 'package:video_grabber_app/features/home/data/datasources/extraction_platform_data_source.dart';
import 'package:video_grabber_app/features/home/data/datasources/video_download_data_source.dart';
import 'package:video_grabber_app/features/home/data/repositories/extraction_repository_impl.dart';
import 'package:video_grabber_app/features/home/data/repositories/download_repository_impl.dart';
import 'package:video_grabber_app/features/history/data/repositories/history_repository_impl.dart';
import 'package:video_grabber_app/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:video_grabber_app/core/data/datasources/cookie_storage_data_source.dart';
import 'package:video_grabber_app/core/data/repositories/cookie_repository_impl.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GrabItApp(
      extractionRepo: ExtractionRepositoryImpl(ExtractionPlatformDataSourceImpl()),
      downloadRepo: DownloadRepositoryImpl(VideoDownloadDataSourceImpl(Dio())),
      historyRepo: HistoryRepositoryImpl(),
      settingsRepo: SettingsRepositoryImpl(),
      cookieRepo: CookieRepositoryImpl(CookieStorageDataSourceImpl()),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
