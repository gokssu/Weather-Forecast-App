import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generated/generated.dart';
import 'package:weather_forecast_app/core/providers/index.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/core/widgets/city_search_bar.dart';
import 'package:weather_forecast_app/core/widgets/units_switch_widget.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_controller/current_weather_repository.dart';

// currentWetherServiceProvider
final currentWetherServiceProvider = Provider<CurrentWeatherService>(
  (ref) =>
      CurrentWeatherService(ref.watch(dioProvider), baseUrl: Config.apiUrl),
);

// currentWetherRepositoryProvider
final currentWetherRepositoryProvider = Provider<CurrentWeatherRepository>(
  (ref) => CurrentWeatherRepository(
    currentWeatherService: ref.watch(currentWetherServiceProvider),
  ),
);

final getCurrentProvider = FutureProvider.autoDispose
    .family<Either<Failure, CurrentWeather>, String>((ref, langCode) async {
      final isCelsius = ref.watch(isUnitCelsiusProvider);
      final cityName = ref.watch(selectedCityProvider);
      final locationState = ref.watch(locationNotifierProvider);
      final parameters = GetCurrentParams(
        cityName: cityName,
        lat: locationState.hasValue ? locationState.value?.latitude ?? 0 : 0,
        long: locationState.hasValue ? locationState.value?.longitude ?? 0 : 0,
        unitCelsius: isCelsius,
        langCode: langCode,
      );
      final currentWeather = await ref
          .watch(currentWetherRepositoryProvider)
          .getCurrentLocation(parameters);
      return currentWeather;
    });
