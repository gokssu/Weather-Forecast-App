import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast_app/core/widgets/index.dart';
import 'package:weather_forecast_app/core/providers/location_provider.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_controller/daily_weather_provider.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_view/daily_weather_widget.dart';

class DailyWeatherScreen extends HookConsumerWidget {
  const DailyWeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationNotifierProvider);
    return BaseWidget(
      resizeToAvoidBottomInset: true,
      childBody: locationState.when(
        data: (position) {
          if (position == null) {
            return Center(child: Text('Location is not found.').tr());
          }
          final dailyWeather = ref.watch(
            get7DayProvider(context.locale.languageCode),
          );
          return dailyWeather.when(
            data:
                (either) => either.fold(
                  (failure) => ErrorHandlingScreen(failure: failure),
                  (weather) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(
                          get7DayProvider(context.locale.languageCode),
                        );
                        ref.invalidate(locationNotifierProvider);
                      },
                      child: ListView(
                        children: [
                          const CitySearchBar(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: UnitsSwitchWidget(position: position),
                          ),
                          Text(
                            'Weekly Forecast'.tr(),
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          DailyWeatherWidget(weather: weather),
                        ],
                      ),
                    ),
                  ),
                ),
            error:
                (e, st) => ErrorScreen(
                  errorMessage: 'Weather could not be received'.tr(),
                ),
            loading: () => const LoadingScreen(),
          );
        },
        error: (e, st) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${'Location error'.tr()}: $e'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await Geolocator.openLocationSettings();
                    ref
                        .read(locationNotifierProvider.notifier)
                        .refreshLocation();
                  },
                  child: const Text('Open Location Settings').tr(),
                ),
              ],
            ),
          );
        },
        loading: () => const LoadingScreen(),
      ),
    );
  }
}
