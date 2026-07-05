import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/preview/presentation/pages/preview_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/instagram_auth/presentation/pages/instagram_login_page.dart';
import '../../domain/entities/video_info.dart';
import '../widgets/main_wrapper.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/preview',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final videoInfo = state.extra as VideoInfo;
          return PreviewPage(videoInfo: videoInfo);
        },
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/instagram-login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const InstagramLoginPage(),
      ),
    ],
  );
}

