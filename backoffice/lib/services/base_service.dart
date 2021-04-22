import 'package:backoffice/config/config.dart';
import 'package:backoffice/exceptions/exceptions.dart';

class BaseService {
  String getBaseUrl () {
    final config = BackOfficeConfig.instance;

    if (config != null) {
      return config.baseUrl;
    }

    throw ImproperlyConfiguredException(message: 'Base URL not provided');
  }

  Uri getMethodUri(String methodName) => Uri.parse(this.getBaseUrl() + methodName);
}