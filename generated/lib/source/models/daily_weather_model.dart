import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_weather_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class DailyWeather extends HiveObject {
  DailyWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.tempDay,
    required this.tempMin,
    required this.tempMax,
    required this.tempNight,
    required this.tempEve,
    required this.tempMorn,
    required this.feelsLikeDay,
    required this.feelsLikeNight,
    required this.feelsLikeEve,
    required this.feelsLikeMorn,
    required this.pressure,
    required this.humidity,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.windSpeed,
    required this.windDeg,
    required this.clouds,
    required this.pop,
    this.windGust,
    this.rain,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherFromJson(json);
  @HiveField(0)
  final int dt;

  @HiveField(1)
  final int sunrise;

  @HiveField(2)
  final int sunset;

  @HiveField(3)
  final double tempDay;

  @HiveField(4)
  final double tempMin;

  @HiveField(5)
  final double tempMax;

  @HiveField(6)
  final double tempNight;

  @HiveField(7)
  final double tempEve;

  @HiveField(8)
  final double tempMorn;

  @HiveField(9)
  final double feelsLikeDay;

  @HiveField(10)
  final double feelsLikeNight;

  @HiveField(11)
  final double feelsLikeEve;

  @HiveField(12)
  final double feelsLikeMorn;

  @HiveField(13)
  final int pressure;

  @HiveField(14)
  final int humidity;

  @HiveField(15)
  final String weatherMain;

  @HiveField(16)
  final String weatherDescription;

  @HiveField(17)
  final String weatherIcon;

  @HiveField(18)
  final double windSpeed;

  @HiveField(19)
  final int windDeg;

  @HiveField(20)
  final double? windGust;

  @HiveField(21)
  final int clouds;

  @HiveField(22)
  final double pop;

  @HiveField(23)
  final double? rain;

  Map<String, dynamic> toJson() => _$DailyWeatherToJson(this);
}
