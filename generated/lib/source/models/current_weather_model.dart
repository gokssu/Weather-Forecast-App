import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_weather_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CurrentWeather extends HiveObject {
  CurrentWeather({
    required this.lon,
    required this.lat,
    required this.mainWeather,
    required this.description,
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

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
  @HiveField(0)
  final double lon;

  @HiveField(1)
  final double lat;

  @HiveField(2)
  final String mainWeather;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final double temp;

  @HiveField(5)
  final double feelsLike;

  @HiveField(6)
  final double tempMin;

  @HiveField(7)
  final double tempMax;

  @HiveField(8)
  final int pressure;

  @HiveField(9)
  final int humidity;

  @HiveField(10)
  final double windSpeed;

  @HiveField(11)
  final int windDeg;

  @HiveField(12)
  final String cityName;

  @HiveField(13)
  final double? rainLastHour;

  @HiveField(14)
  final int cloudiness;

  @HiveField(15)
  final int visibility;

  @HiveField(16)
  final int timezone;

  @HiveField(17)
  final String country;

  @HiveField(18)
  final int sunrise;

  @HiveField(19)
  final int sunset;

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);

  CurrentWeather copyWith({
    double? lon,
    double? lat,
    String? mainWeather,
    String? description,
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
