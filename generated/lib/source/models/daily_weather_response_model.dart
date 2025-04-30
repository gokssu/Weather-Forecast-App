import 'package:generated/source/models/index.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_weather_response_model.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class DailyWeatherResponse extends HiveObject {
  DailyWeatherResponse({required this.city, required this.list});

  factory DailyWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherResponseFromJson(json);
  @HiveField(0)
  final City city;

  @HiveField(1)
  final List<HourlyWeather> list;

  Map<String, dynamic> toJson() => _$DailyWeatherResponseToJson(this);
}
