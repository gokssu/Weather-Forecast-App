import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_weather_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class CurrentWeather extends HiveObject {
  CurrentWeather({
    required this.lon,
    required this.lat,
    required this.mainWeather,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.cityName,
    required this.cloudiness,
    required this.visibility,
    required this.timezone,
    required this.country,
    required this.sunrise,
    required this.sunset,
    this.rainLastHour,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final coord = json['coord'] as Map<String, dynamic>?;
    final main = json['main'] as Map<String, dynamic>?;
    final wind = json['wind'] as Map<String, dynamic>?;
    final clouds = json['clouds'] as Map<String, dynamic>?;
    final sys = json['sys'] as Map<String, dynamic>?;
    final rain = json['rain'] as Map<String, dynamic>?;
    final weatherList = json['weather'] as List<dynamic>?;

    final weather =
        (weatherList != null && weatherList.isNotEmpty)
            ? weatherList.first as Map<String, dynamic>
            : {};

    return CurrentWeather(
      lon: (coord?['lon'] as num?)?.toDouble(),
      lat: (coord?['lat'] as num?)?.toDouble(),
      mainWeather: weather['main'] as String? ?? '',
      description: weather['description'] as String? ?? '',
      icon: weather['icon'] as String? ?? '',
      temp: (main?['temp'] as num?)?.toDouble(),
      feelsLike: (main?['feels_like'] as num?)?.toDouble(),
      tempMin: (main?['temp_min'] as num?)?.toDouble(),
      tempMax: (main?['temp_max'] as num?)?.toDouble(),
      pressure: (main?['pressure'] as num?)?.toInt(),
      humidity: (main?['humidity'] as num?)?.toInt(),
      windSpeed: (wind?['speed'] as num?)?.toDouble(),
      windDeg: (wind?['deg'] as num?)?.toInt(),
      cityName: json['name'] as String? ?? '',
      rainLastHour: (rain?['1h'] as num?)?.toDouble(),
      cloudiness: (clouds?['all'] as num?)?.toInt(),
      visibility: (json['visibility'] as num?)?.toInt(),
      timezone: (json['timezone'] as num?)?.toInt(),
      country: sys?['country'] as String? ?? '',
      sunrise: (sys?['sunrise'] as num?)?.toInt(),
      sunset: (sys?['sunset'] as num?)?.toInt(),
    );
  }

  @HiveField(0)
  final double? lon;

  @HiveField(1)
  final double? lat;

  @HiveField(2)
  final String? mainWeather;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final double? temp;

  @HiveField(5)
  final double? feelsLike;

  @HiveField(6)
  final double? tempMin;

  @HiveField(7)
  final double? tempMax;

  @HiveField(8)
  final int? pressure;

  @HiveField(9)
  final int? humidity;

  @HiveField(10)
  final double? windSpeed;

  @HiveField(11)
  final int? windDeg;

  @HiveField(12)
  final String? cityName;

  @HiveField(13)
  final double? rainLastHour;

  @HiveField(14)
  final int? cloudiness;

  @HiveField(15)
  final int? visibility;

  @HiveField(16)
  final int? timezone;

  @HiveField(17)
  final String? country;

  @HiveField(18)
  final int? sunrise;

  @HiveField(19)
  final int? sunset;

  @HiveField(20)
  final String? icon;

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);

  CurrentWeather copyWith({
    double? lon,
    double? lat,
    String? mainWeather,
    String? description,
    String? icon,
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
    double? windSpeed,
    int? windDeg,
    String? cityName,
    double? rainLastHour,
    int? cloudiness,
    int? visibility,
    int? timezone,
    String? country,
    int? sunrise,
    int? sunset,
  }) {
    return CurrentWeather(
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
      mainWeather: mainWeather ?? this.mainWeather,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      windDeg: windDeg ?? this.windDeg,
      cityName: cityName ?? this.cityName,
      rainLastHour: rainLastHour ?? this.rainLastHour,
      cloudiness: cloudiness ?? this.cloudiness,
      visibility: visibility ?? this.visibility,
      timezone: timezone ?? this.timezone,
      country: country ?? this.country,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }
}
