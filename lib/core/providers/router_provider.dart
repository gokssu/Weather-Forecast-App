import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_view/current_weather_screen.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_view/daily_weather_screen.dart';
import 'package:weather_forecast_app/features/daily_weather_detail_view/daily_weather_detail_screen.dart';
import 'package:weather_forecast_app/features/home/home_view/home_screen.dart';
import 'package:weather_forecast_app/features/settings/settings_view/settings_screen.dart';
import 'package:weather_forecast_app/features/splash/splash_screen.dart';

class Routes {
  static const initial = '/';
  static const current = '/current';
  static const daily = '/daily';
  static const dailyDetail = '/daily_detail/:date';
  static const settings = '/settings';
  static String build(String route, List<String> params) =>
      [route, ...params].join('/');
}

final navigatorKey = GlobalKey<NavigatorState>();
final shellNavigator = GlobalKey<NavigatorState>(debugLabel: 'shell');

final homeIndexProvider = StateProvider<int>((ref) {
  return 0;
});
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    errorBuilder: (context, state) => ErrorPage(state: state),
    routes: [
      buildRoute(Routes.initial, const SplashScreen()),
      ShellRoute(
        navigatorKey: shellNavigator,
        builder:
            (context, state, child) =>
                HomeScreen(key: state.pageKey, child: child),

        routes: [
          GoRoute(
            path: Routes.current,
            name: Routes.current,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: CurrentWeatherScreen(key: state.pageKey),
              );
            },
          ),
          GoRoute(
            path: Routes.daily,
            name: Routes.daily,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: DailyWeatherScreen(key: state.pageKey),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: shellNavigator,
                path: Routes.dailyDetail,
                name: Routes.dailyDetail,
                pageBuilder: (context, state) {
                  final date = state.pathParameters['date'].toString();
                  return NoTransitionPage(
                    child: DailyWeatherDetailScreen(
                      date: date,
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.settings,
            name: Routes.settings,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: SettingsScreen(key: state.pageKey),
              );
            },
          ),
        ],
      ),
    ],
  );
});

GoRoute buildRoute(String path, Widget screen) => GoRoute(
  path: path,
  builder: (BuildContext context, GoRouterState state) => screen,
);

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.state, super.key});
  final GoRouterState state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            '${'Oops!! There are no results found.'.tr()} \n ${state.error}',
            textAlign: TextAlign.center,
            style: context.general.textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
