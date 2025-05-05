import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generated/generated.dart';
import 'package:weather_forecast_app/core/providers/index.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/core/widgets/city_search_bar.dart';
import 'package:weather_forecast_app/core/widgets/units_switch_widget.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_controller/daily_weather_repository.dart';

// hourlyWetherServiceProvider
final hourlyWetherServiceProvider = Provider<HourlyWeatherService>(
  (ref) => HourlyWeatherService(ref.watch(dioProvider), baseUrl: Config.apiUrl),
);

// hourlyWetherRepositoryProvider
final dailyWetherRepositoryProvider = Provider<DailyWeatherRepository>(
  (ref) => DailyWeatherRepository(
    hourlyWeatherService: ref.watch(hourlyWetherServiceProvider),
  ),
);

final getOneDayProvider = FutureProvider.autoDispose
    .family<Either<Failure, DailyWeatherResponse>, String>((
      ref,
      langCode,
    ) async {
      final isCelsius = ref.watch(isUnitCelsiusProvider);
      final cityName = ref.watch(selectedCityProvider);
      final locationState = ref.watch(locationNotifierProvider);
      final parameters = GetDailyParams(
        cityName: cityName,
        lat: locationState.hasValue ? locationState.value?.latitude ?? 0 : 0,
        long: locationState.hasValue ? locationState.value?.longitude ?? 0 : 0,
        unitCelsius: isCelsius,
        langCode: langCode,
        count: '8',
      );
      final dailyWeather = await ref
          .watch(dailyWetherRepositoryProvider)
          .getDailyLocation(parameters);
      return dailyWeather;
    });

final get7DayProvider = FutureProvider.autoDispose
    .family<Either<Failure, DailyWeatherResponse>, String>((
      ref,
      langCode,
    ) async {
      final isCelsius = ref.watch(isUnitCelsiusProvider);
      final cityName = ref.watch(selectedCityProvider);
      final locationState = ref.watch(locationNotifierProvider);
      final parameters = GetDailyParams(
        cityName: cityName,
        lat: locationState.hasValue ? locationState.value?.latitude ?? 0 : 0,
        long: locationState.hasValue ? locationState.value?.longitude ?? 0 : 0,
        unitCelsius: isCelsius,
        langCode: langCode,
        count: '56',
      );
      final dailyWeather = await ref
          .watch(dailyWetherRepositoryProvider)
          .getDailyLocation(parameters);
      return dailyWeather;
    });
