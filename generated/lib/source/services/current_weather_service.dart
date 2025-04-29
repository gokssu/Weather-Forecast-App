import 'package:dio/dio.dart';
import 'package:generated/source/index.dart';
import 'package:retrofit/http.dart';

part 'current_weather_service.g.dart';

@RestApi()
abstract class CurrentWeatherService {
  factory CurrentWeatherService(Dio dio, {String baseUrl}) =
      _CurrentWeatherService;

  @GET('lat={lat}&lon={lon}&appid={apiKey}&units={units}&lang={lang}')
  Future<CurrentWeather> getWithLocation(
    @Path() String apiKey,
    @Path() String units,
    @Path() String lang,
    @Path() String lat,
    @Path() String lon,
  );
}
