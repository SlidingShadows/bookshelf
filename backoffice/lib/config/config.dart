class BackOfficeConfig {
  final String authority;
  final bool useHttps;
  static BackOfficeConfig? _instance;

  factory BackOfficeConfig({
    required String authority,
    required bool useHttps,
  }) => _instance ??= BackOfficeConfig._(authority, useHttps);

  BackOfficeConfig._(this.authority, this.useHttps);

  static BackOfficeConfig? get instance => _instance;
}