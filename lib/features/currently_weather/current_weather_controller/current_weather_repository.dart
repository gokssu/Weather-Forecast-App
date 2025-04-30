import 'package:generated/generated.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:equatable/equatable.dart';

class CurrentWeatherRepository {
  final CurrentWeatherService currentWeatherService;
  final Box<CurrentWeather> _currentWeatherBox = Hive.box<CurrentWeather>(
    Config.currentWeather,
  );
  CurrentWeatherRepository({required this.currentWeatherService});

  Future<CurrentWeather> getCurrentLocation(GetCurrentParams params) async {
    try {
      final currentWeather = await currentWeatherService.getCurrentWeather(
        Config.apiKeyOpenWeather,
        params.unitCelsius ? 'metric' : 'imperial',
        params.langCode,
        params.lat.toString(),
        params.long.toString(),
        params.cityName,
      );
      await _saveCurrentWeatherToLocal(currentWeather);
      return currentWeather;
    } catch (e) {
      return _currentWeatherBox.values.isNotEmpty
          ? _currentWeatherBox.values.last
          : throw Exception('No cached data');
    }
  }

  Future<void> _saveCurrentWeatherToLocal(CurrentWeather currentWeather) async {
    await _currentWeatherBox.clear();
    String id = Uuid().v4();
    await _currentWeatherBox.put(id, currentWeather);
  }
}

class GetCurrentParams extends Equatable {
  final String cityName;
  final double lat;
  final double long;
  final bool unitCelsius;
  final String langCode;

  const GetCurrentParams({
    required this.cityName,
    required this.lat,
    required this.long,
    required this.unitCelsius,
    required this.langCode,
  });

  @override
  List<Object> get props => [cityName, long, unitCelsius, langCode];
}
