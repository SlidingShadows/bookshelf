import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

class AuthenticationSuccess extends AuthenticationState {
  final String token;

  const AuthenticationSuccess(this.token);

  @override
  List<Object?> get props => [token];
}

class AuthenticationErrors extends AuthenticationState {
  final String? email;
  final Map<String, String> errors;

  const AuthenticationErrors(this.email, this.errors);

  @override
  List<Object?> get props => [errors];
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure(this.message);

  @override
  List<Object?> get props => [message];
}