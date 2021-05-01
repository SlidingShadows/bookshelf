import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:backoffice/api/api.dart' as api;
import 'package:backoffice/config/config.dart';
import 'package:backoffice/services/local_storage.dart' as local;

// For now use simple map. In future best way to use annotations
final jsonResponseFactories = <Type, Function> {
  api.AuthenticationResponse: (Map<String, dynamic> json) => api.AuthenticationResponse.fromJson(json),
};

class Client {
  final http.Client _client;
  final String? token;

  Client({
    this.token,
  }): _client = http.Client();

  Future<T> post<T>(String path, {
    api.Request? request,
    Map<String, dynamic>? queryParameters
  }) async {

    final response = await _client.post(
      _getUri(path, queryParameters),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.acceptHeader: 'application/json',
        if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: (request != null) ? json.encode(request.toJson()) : null,
    );

    return _proceedResponse<T>(response);
  }

  void close () {
    _client.close();
  }

  T _proceedResponse<T> (http.Response response) {
    if (response.statusCode == 200)
      return jsonResponseFactories[T]!(json.decode(response.body));

    throw Exception('Fatal error');
  }

  Uri _getUri (String path, Map<String, dynamic>? queryParameters) {
    return BackOfficeConfig.instance!.useHttps ?
      Uri.https(BackOfficeConfig.instance!.authority, path, queryParameters):
      Uri.http(BackOfficeConfig.instance!.authority, path, queryParameters);
  }
}