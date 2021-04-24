import 'package:backoffice/api/api.dart';

class AuthenticationRequest extends Request {
  final String email;
  final String password;

  AuthenticationRequest(this.email, this.password);

  @override
  Map<String, dynamic> toJson() => <String, dynamic> {
    'email': email,
    'password': password,
  };
}