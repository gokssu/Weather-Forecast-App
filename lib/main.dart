import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_forecast_app/core/init/app_localization.dart';
import 'package:weather_forecast_app/core/init/application_initialize.dart';
import 'package:weather_forecast_app/core/providers/router_provider.dart';
import 'package:weather_forecast_app/core/providers/theme_provider.dart';
import 'package:weather_forecast_app/core/theme/text_theme.dart';
import 'package:weather_forecast_app/core/theme/theme.dart';

Future<void> main() async {
  await ApplicationInitialize().make();
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  final themeNotifier = await ThemeNotifier.create(brightness);
  runApp(
    AppLocalization(
      child: ProviderScope(
        overrides: [themeNotifierProvider.overrideWithValue(themeNotifier)],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = createTextTheme(context, 'Montserrat', 'Montserrat');
    final theme = MaterialTheme(textTheme);
    final themeMode = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: themeMode,
      theme: themeMode == ThemeMode.light ? theme.light() : theme.dark(),
      routerConfig: router,
    );
  }
}
