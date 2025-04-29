import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/init/app_localization.dart';
import 'package:weather_forecast_app/core/providers/theme_provider.dart';
import 'package:weather_forecast_app/core/widgets/base_widget.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_controller/location_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final notifier = ref.read(themeProvider.notifier);
    final Map<String, String> flagAssets = {
      'tr': '🇹🇷',
      'en': '🇬🇧',
      'de': '🇩🇪',
    };
    return BaseWidget(
      resizeToAvoidBottomInset: true,
      padding: const EdgeInsets.all(8),
      childBody: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode :',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ).tr(),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.dark_mode,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: notifier.toggleTheme,
                    ),
                    Switch(
                      value: themeMode != ThemeMode.dark,
                      activeColor: Theme.of(context).colorScheme.inversePrimary,
                      onChanged: (bool value) {
                        notifier.toggleTheme();
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.light_mode,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: notifier.toggleTheme,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language :',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ).tr(),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: DropdownButton<Locale>(
                        icon: SizedBox(),
                        underline: SizedBox(),
                        menuWidth: 100,
                        value: context.locale,
                        onChanged: (newValue) {
                          if (newValue != null) {
                            AppLocalization.updateLanguage(
                              context: context,
                              value: newValue,
                            );
                          }
                        },
                        items:
                            context.supportedLocales.map((Locale locale) {
                              return DropdownMenuItem<Locale>(
                                value: locale,
                                child: Row(
                                  children: [
                                    Text(
                                      flagAssets[locale.languageCode] ?? '',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(locale.countryCode ?? ''),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  ref.read(locationNotifierProvider.notifier).refreshLocation();
                },
                child: Text('Get Current Location'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
