class ImproperlyConfiguredException implements Exception {
  final String message;

  ImproperlyConfiguredException({this.message = 'Unknown error occurred'});
}