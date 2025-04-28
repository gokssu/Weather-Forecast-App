import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:weather_forecast_app/features/home/home_view/home_screen.dart';
import 'package:weather_forecast_app/features/splash/splash_screen.dart';

class Routes {
  static const initial = '/';
  static const home = '/home';
  static String build(String route, List<String> params) =>
      [route, ...params].join('/');
}

final navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    errorBuilder: (context, state) => ErrorPage(state: state),
    routes: [
      buildRoute(Routes.initial, const SplashScreen()),
      buildRoute(Routes.home, const HomeScreen()),
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
