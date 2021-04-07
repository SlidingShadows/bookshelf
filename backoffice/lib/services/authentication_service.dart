import 'package:backoffice/models/models.dart';

abstract class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<User> signIn(String email, String password);
  Future<void> signOut();
}

class AuthenticationServiceImpl implements AuthenticationService {
  @override
  Future<User?> getCurrentUser() async {
    return null;
  }

  @override
  Future<User> signIn(String email, String password) async {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    return;
  }
  
}