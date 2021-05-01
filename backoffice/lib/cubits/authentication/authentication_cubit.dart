import 'package:backoffice/api/api.dart';
import 'package:backoffice/cubits/authentication/authentication.dart';
import 'package:bloc/bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> login(String email, String password) async {
    final client = Client();
    emit(AuthenticationLoading());

    try {
      final response = await client.post<AuthenticationResponse>(
        '/auth/login',
        request: AuthenticationRequest(email, password),
      );

      if (response.succeeded) emit(AuthenticationSuccess(response.token!));
      else emit(AuthenticationErrors({ for (var e in response.errors) e.code: e.description }));

    } catch (e) {
      emit(AuthenticationFailure('An unknown error occurred'));
    } finally {
      client.close();
    }
  }
  
  void logout() {
    emit(AuthenticationInitial());
  }
}