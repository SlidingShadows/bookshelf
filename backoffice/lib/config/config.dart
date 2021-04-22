class BackOfficeConfig {
  final String baseUrl;
  static BackOfficeConfig? _instance;

  factory BackOfficeConfig({
    required String baseUrl,
  }) => _instance ??= BackOfficeConfig._(baseUrl);

  BackOfficeConfig._(this.baseUrl);

  static BackOfficeConfig? get instance => _instance;
}