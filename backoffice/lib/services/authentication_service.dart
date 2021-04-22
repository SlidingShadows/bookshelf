import 'dart:convert';
import 'package:backoffice/exceptions/exceptions.dart';
import 'package:backoffice/models/models.dart';
import 'package:backoffice/api/api.dart';
import 'package:backoffice/services/local_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'base_service.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<User> signIn(String email, String password);
  Future<void> signOut();
}

class AuthenticationServiceImpl with BaseService implements AuthenticationService {
  @override
  Future<User?> getCurrentUser() async {
    final token = await loadToken();

    if (token != null) {
      return _loadFromToken(token);
    }

    return null;
  }

  @override
  Future<User> signIn(String email, String password) async {
    final request = AuthenticationRequest(email, password);

    final httpResponse = await http.post(
      getMethodUri('/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(request.toJson()),
    );

    if (httpResponse.statusCode == 200) {
       final response = AuthenticationResponse.fromJson(json.decode(httpResponse.body));

      if (response.succeeded) {
        final token = response.token;

        if (token != null) {
          storeToken(token);
          return _loadFromToken(token);
        }
      }

      throw AuthenticationException(message: response.errors[0].description);
    }

    throw Exception('Fatal error');
  }

  User _loadFromToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return User(email: decodedToken['sub']);
  }

  @override
  Future<void> signOut() async {
    await clearToken();
  }
  
}