import 'package:backoffice/blocs/blocs.dart';
import 'package:backoffice/pages/pages.dart';
import 'package:backoffice/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:backoffice/config/config.dart';

void main() {
  BackOfficeConfig(
      baseUrl: 'https://localhost:44332',
  );

  runApp(
    RepositoryProvider<AuthenticationService> (
      create: (context) => AuthenticationServiceImpl(),
      child: BlocProvider<AuthenticationBloc> (
        create: (context) {
          final authService = RepositoryProvider.of<AuthenticationService>(context);
          return AuthenticationBloc(authService)..add(AppLoaded());
        },
        child: BackOffice(),
      ),
    )
  );
}

class BackOffice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BackOffice',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState> (
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomePage(
              user: state.user,
            );
          }

          return LoginPage();
        },
      ),
    );
  }
}