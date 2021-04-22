class AuthenticationRequest {
  final String email;
  final String password;

  AuthenticationRequest(this.email, this.password);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'email': email,
    'password': password,
  };
}