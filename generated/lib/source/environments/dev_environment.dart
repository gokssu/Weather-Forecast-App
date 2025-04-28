import 'package:envied/envied.dart';
import 'package:generated/source/environments/app_config_env.dart';

part 'dev_environment.g.dart';

@Envied(path: 'assets/env/.dev.env', obfuscate: true)
final class DevEnvironment implements AppConfigurationEnv {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _DevEnvironment._baseUrl;

  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = DevEnvironment._apiKey;

  @override
  String get apiKey => _apiKey;

  @override
  String get baseUrl => _baseUrl;
}
