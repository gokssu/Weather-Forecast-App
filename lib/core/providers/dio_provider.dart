import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_forecast_app/core/utils/config.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio =
      Dio()
        ..interceptors.add(
          PrettyDioLogger(requestHeader: true, requestBody: true),
        )
        ..options.connectTimeout = const Duration(milliseconds: 50000)
        ..options.receiveTimeout = const Duration(milliseconds: 30000)
        ..options.baseUrl = Config.apiUrl;

  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) =>
            Config.apiUrl.contains(host);

    return client;
  };

  return dio;
});
