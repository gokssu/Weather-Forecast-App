import 'package:generated/generated.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

class DailyWeatherRepository {
  final HourlyWeatherService hourlyWeatherService;
  final Box<DailyWeatherResponse> _dailyWeatherBox =
      Hive.box<DailyWeatherResponse>(Config.dailyWeather);
  DailyWeatherRepository({required this.hourlyWeatherService});

  Future<Either<Failure, DailyWeatherResponse>> getDailyLocation(
    GetDailyParams params,
  ) async {
    try {
      final dailyWeatherResponse = await hourlyWeatherService.getDailyWeather(
        Config.apiKeyOpenWeather,
        params.unitCelsius ? 'metric' : 'imperial',
        params.langCode,
        params.lat.toString(),
        params.long.toString(),
        params.cityName,
        params.count,
      );

      await _saveDailyWeatherToLocal(dailyWeatherResponse);
      return Right(dailyWeatherResponse);
    } catch (e) {
      final failure = NetworkFailure.process(e);
      if (_dailyWeatherBox.values.isNotEmpty) {
        return Right(_dailyWeatherBox.values.last);
      }
      return Left(failure);
    }
  }

  Future<void> _saveDailyWeatherToLocal(
    DailyWeatherResponse dailyWeather,
  ) async {
    await _dailyWeatherBox.clear();
    String id = Uuid().v4();
    await _dailyWeatherBox.put(id, dailyWeather);
  }
}

class GetDailyParams extends Equatable {
  final String cityName;
  final double lat;
  final double long;
  final bool unitCelsius;
  final String langCode;
  final String count;

  const GetDailyParams({
    required this.cityName,
    required this.lat,
    required this.long,
    required this.unitCelsius,
    required this.langCode,
    required this.count,
  });

  @override
  List<Object> get props => [cityName, long, unitCelsius, langCode, count];
}
