class AppEnvironment {
  late final String _apiKey;

  String get apiKey => _apiKey;

  AppEnvironment.initialize() {
    _apiKey = const String.fromEnvironment("apiKey");
  }

}