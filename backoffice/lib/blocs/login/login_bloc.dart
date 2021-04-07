import 'package:backoffice/blocs/blocs.dart';
import 'package:backoffice/exceptions/exceptions.dart';
import 'package:backoffice/services/services.dart';
import 'login_state.dart';
import 'login_event.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  final AuthenticationService authenticationService;

  LoginBloc({required this.authenticationBloc, required this.authenticationService}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(event);
    }
  }

  Stream<LoginState> _mapLoginButtonPressedToState(LoginButtonPressed event) async* {
    yield LoginLoading();

    try {
      final user = await authenticationService.signIn(event.email, event.password);
      authenticationBloc.add(UserLoggedIn(user: user));
      yield LoginSuccess();
      yield LoginInitial();
    } on AuthenticationException catch (e) {
      yield LoginFailure(error: e.message);
    } catch (e) {
      yield LoginFailure(error: 'An unknown error occurred');
    }
  }

}