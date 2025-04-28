import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:weather_forecast_app/core/init/app_environment.dart';
import 'package:weather_forecast_app/core/init/app_localization.dart';
import 'package:weather_forecast_app/core/providers/theme_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final notifier = ref.read(themeProvider.notifier);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              color: context.general.colorScheme.inversePrimary,
            ),
            onPressed: notifier.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome').tr(),

            Text(AppEnvironmentItems.baseUrl.value).tr(),
            ElevatedButton(
              onPressed: () {
                AppLocalization.updateLanguage(
                  context: context,
                  value: Locales.tr,
                );
              },
              child: Text(
                'change lang tr',
                style: context.general.textTheme.bodySmall,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AppLocalization.updateLanguage(
                  context: context,
                  value: Locales.de,
                );
              },
              child: const Text('change lang de'),
            ),
            ElevatedButton(
              onPressed: () {
                AppLocalization.updateLanguage(
                  context: context,
                  value: Locales.en,
                );
              },
              child: const Text('change lang en'),
            ),
          ],
        ),
      ),
    );
  }
}
