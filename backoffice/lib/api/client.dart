import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:backoffice/api/api.dart' as api;
import 'package:backoffice/config/config.dart';
import 'package:backoffice/exceptions/exceptions.dart';
import 'package:backoffice/services/local_storage.dart' as local;

// For now use simple map. In future best way to use annotations
final jsonResponseFactories = <Type, Function> {
  api.AuthenticationResponse: (Map<String, dynamic> json) => api.AuthenticationResponse.fromJson(json),
};

class Client {
  final http.Client _client;

  Client(): _client = http.Client();

  Future<T> post<T>(String path, {
    api.Request? request,
    bool secured = true,
    Map<String, dynamic>? queryParameters
  }) async {

    final response = await _client.post(
      _getUri(path, queryParameters),
      headers: await _getHeaders(secured),
      body: _getBody(request),
    );

    return _proceedResponse<T>(response);
  }

  void close () {
    _client.close();
  }

  T _proceedResponse<T> (http.Response response) {
    if (response.statusCode == 200) {
      final factory = jsonResponseFactories[T];

      if (factory != null) {
        return factory(json.decode(response.body));
      }

      throw ImproperlyConfiguredException(message: 'Factory not provided');
    }

    throw Exception('Fatal error');
  }

  Future<Map<String, String>> _getHeaders (bool secured) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (secured) {
      var token = await local.loadToken();
      if (token != null) {
        headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }
    }

    return headers;
  }

  String? _getBody (api.Request? request) {
    if (request != null) {
      return json.encode(request.toJson());
    }

    return null;
  }

  Uri _getUri (String path, Map<String, dynamic>? queryParameters) {
    final config = BackOfficeConfig.instance;

    if (config != null) {
      return config.useHttps ?
        Uri.https(config.authority, path, queryParameters):
        Uri.http(config.authority, path, queryParameters);
    }

    throw ImproperlyConfiguredException(message: 'Authority not provided');
  }
}