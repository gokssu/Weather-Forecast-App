import 'package:flutter/foundation.dart';
import 'package:generated/generated.dart';

/// Application environment manager class
final class AppEnvironment {
  /// Setup application environment
  AppEnvironment.setup({required AppConfigurationEnv config}) {
    _config = config;
  }

  /// General application environment setup
  AppEnvironment.general() {
    _config = kDebugMode ? DevEnvironment() : ProdEnvironment();
  }

  static late final AppConfigurationEnv _config;
}

/// Get application environment items
enum AppEnvironmentItems {
  /// Network base url
  baseUrl,

  apiKey;

  /// Get application environment item value
  String get value {
    try {
      switch (this) {
        case AppEnvironmentItems.baseUrl:
          return AppEnvironment._config.baseUrl;
        case AppEnvironmentItems.apiKey:
          return AppEnvironment._config.apiKey;
      }
    } on Exception catch (e) {
      throw Exception('AppEnvironment is not initialized. $e');
    }
  }
}
