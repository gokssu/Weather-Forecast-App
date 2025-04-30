import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class City extends HiveObject {
  City({
    required this.id,
    required this.name,
    required this.lon,
    required this.lat,
    required this.country,
    required this.population,
    required this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    final coord = json['coord'] as Map<String, dynamic>?;

    return City(
      id: json['id'] as int?,
      name: json['name'] as String?,
      lon: (coord?['lon'] as num?)?.toDouble(),
      lat: (coord?['lat'] as num?)?.toDouble(),
      country: json['country'] as String?,
      population: json['population'] as int?,
      timezone: json['timezone'] as int?,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
    );
  }

  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final double? lon;

  @HiveField(3)
  final double? lat;

  @HiveField(4)
  final String? country;

  @HiveField(5)
  final int? population;

  @HiveField(6)
  final int? timezone;

  @HiveField(7)
  final int? sunrise;

  @HiveField(8)
  final int? sunset;

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
