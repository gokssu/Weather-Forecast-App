import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_controller/current_weather_provider.dart';
import 'package:weather_forecast_app/core/providers/location_provider.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_view/current_hourly_widget.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_view/current_weather_widget.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_controller/daily_weather_provider.dart';
import 'package:weather_forecast_app/core/widgets/index.dart';

class CurrentWeatherScreen extends HookConsumerWidget {
  const CurrentWeatherScreen({super.key});

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

          final currentWeatherAsync = ref.watch(
            getCurrentProvider(context.locale.languageCode),
          );

          return currentWeatherAsync.when(
            data:
                (either) => either.fold(
                  (failure) => ErrorHandlingScreen(failure: failure),
                  (weather) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(
                          getCurrentProvider(context.locale.languageCode),
                        );
                        ref.invalidate(locationNotifierProvider);
                        ref.invalidate(
                          getOneDayProvider(context.locale.languageCode),
                        );
                      },
                      child: ListView(
                        children: [
                          const CitySearchBar(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: UnitsSwitchWidget(position: position),
                          ),
                          CurrentWeatherWidget(weather: weather),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Hourly Forecast'.tr(),
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: const CurrentHourlyWidget(),
                          ),
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
        error:
            (e, st) => Center(
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
            ),
        loading: () => const LoadingScreen(),
      ),
    );
  }
}
