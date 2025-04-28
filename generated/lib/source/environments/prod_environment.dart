import 'package:envied/envied.dart';
import 'package:generated/source/environments/app_config_env.dart';

part 'prod_environment.g.dart';

@Envied(path: 'assets/env/.prod.env', obfuscate: true)
final class ProdEnvironment implements AppConfigurationEnv {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _ProdEnvironment._baseUrl;

  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = _ProdEnvironment._apiKey;

  @override
  String get apiKey => _apiKey;

  @override
  String get baseUrl => _baseUrl;
}
