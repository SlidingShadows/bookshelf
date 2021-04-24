import 'package:backoffice/exceptions/exceptions.dart';
import 'package:backoffice/models/models.dart';
import 'package:backoffice/api/api.dart';
import 'package:backoffice/services/client.dart';
import 'package:backoffice/services/local_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<User> signIn(String email, String password);
  Future<void> signOut();
}

class AuthenticationServiceImpl with AuthenticationService {
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
    final client = Client();

    try {
      final response = await client.post<AuthenticationResponse>(
          '/auth/login',
          request: AuthenticationRequest(email, password),
          secured: false,
      );

      if (response.succeeded) {
        final token = response.token;

        if (token != null) {
          await storeToken(token);
          return _loadFromToken(token);
        }
      }

      throw AuthenticationException(message: response.errors[0].description);
    } finally {
      client.close();
    }
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