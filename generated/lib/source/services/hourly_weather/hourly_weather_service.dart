import 'package:dio/dio.dart';
import 'package:generated/source/index.dart';
import 'package:retrofit/retrofit.dart';

part 'hourly_weather_service.g.dart';

@RestApi()
abstract class HourlyWeatherService {
  factory HourlyWeatherService(Dio dio, {String baseUrl}) =
      _HourlyWeatherService;

  @GET(
    'forecast?q={cityName}&lat={lat}&lon={lon}&cnt={count}&appid={apiKey}&units={units}&lang={lang}',
  )
  Future<DailyWeatherResponse> getDailyWeather(
    @Path() String apiKey,
    @Path() String units,
    @Path() String lang,
    @Path() String lat,
    @Path() String lon,
    @Path() String cityName,
    @Path() String count,
  );
}
