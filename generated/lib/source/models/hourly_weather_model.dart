import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hourly_weather_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(explicitToJson: true)
class HourlyWeather extends HiveObject {
  HourlyWeather({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.groundLevel,
    required this.humidity,
    required this.tempKf,
    required this.mainWeather,
    required this.description,
    required this.icon,
    required this.cloudiness,
    required this.windSpeed,
    required this.windDeg,
    required this.visibility,
    required this.pop,
    required this.pod,
    this.windGust,
    this.rainVolume,
    this.dtTxt,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>?;
    final wind = json['wind'] as Map<String, dynamic>?;
    final clouds = json['clouds'] as Map<String, dynamic>?;
    final weatherList = json['weather'] as List<dynamic>?;
    final weather =
        (weatherList != null && weatherList.isNotEmpty)
            ? weatherList[0] as Map<String, dynamic>
            : <String, dynamic>{};
    final rain = json['rain'] as Map<String, dynamic>?;
    final sys = json['sys'] as Map<String, dynamic>?;

    return HourlyWeather(
      dt: json['dt'] as int,
      temp: (main?['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (main?['feels_like'] as num?)?.toDouble() ?? 0.0,
      tempMin: (main?['temp_min'] as num?)?.toDouble() ?? 0.0,
      tempMax: (main?['temp_max'] as num?)?.toDouble() ?? 0.0,
      pressure: (main?['pressure'] as num?)?.toInt() ?? 0,
      seaLevel: (main?['sea_level'] as num?)?.toInt(),
      groundLevel: (main?['grnd_level'] as num?)?.toInt(),
      humidity: (main?['humidity'] as num?)?.toInt() ?? 0,
      tempKf: (main?['temp_kf'] as num?)?.toDouble(),
      mainWeather: weather['main'] as String? ?? '',
      description: weather['description'] as String? ?? '',
      icon: weather['icon'] as String? ?? '',
      cloudiness: (clouds?['all'] as num?)?.toInt() ?? 0,
      windSpeed: (wind?['speed'] as num?)?.toDouble() ?? 0.0,
      windDeg: (wind?['deg'] as num?)?.toInt() ?? 0,
      windGust: (wind?['gust'] as num?)?.toDouble(),
      visibility: (json['visibility'] as num?)?.toInt() ?? 0,
      pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
      rainVolume: (rain?['3h'] as num?)?.toDouble(),
      pod: sys?['pod'] as String? ?? '',
      dtTxt: json['dt_txt'] as String?,
    );
  }

  @HiveField(0)
  final int dt;

  @HiveField(1)
  final double temp;

  @HiveField(2)
  final double feelsLike;

  @HiveField(3)
  final double tempMin;

  @HiveField(4)
  final double tempMax;

  @HiveField(5)
  final int pressure;

  @HiveField(6)
  final int? seaLevel;

  @HiveField(7)
  final int? groundLevel;

  @HiveField(8)
  final int humidity;

  @HiveField(9)
  final double? tempKf;

  @HiveField(10)
  final String mainWeather;

  @HiveField(11)
  final String description;

  @HiveField(12)
  final String icon;

  @HiveField(13)
  final int cloudiness;

  @HiveField(14)
  final double windSpeed;

  @HiveField(15)
  final int windDeg;

  @HiveField(16)
  final double? windGust;

  @HiveField(17)
  final int visibility;

  @HiveField(18)
  final double pop;

  @HiveField(19)
  final double? rainVolume;

  @HiveField(20)
  final String pod;

  @HiveField(21)
  final String? dtTxt;

  Map<String, dynamic> toJson() => _$HourlyWeatherToJson(this);
}
