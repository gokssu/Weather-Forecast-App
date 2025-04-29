import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generated/generated.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_controller/current_weather_repository.dart';

// dioProvider
final dioProvider = Provider<Dio>((ref) => Dio());

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

final isUnitCelsiusProvider = StateProvider<bool>((ref) => true);

final getCurrentProvider = FutureProvider.autoDispose
    .family<CurrentWeather, GetCurrentParams>((ref, params) async {
      final currentWeather = ref
          .watch(currentWetherRepositoryProvider)
          .getCurrentLocation(
            GetCurrentParams(
              lat: params.lat,
              long: params.long,
              unitCelsius: params.unitCelsius,
              langCode: params.langCode,
            ),
          );
      return currentWeather;
    });
