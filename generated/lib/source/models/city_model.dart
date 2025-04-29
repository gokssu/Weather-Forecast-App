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
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
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

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
