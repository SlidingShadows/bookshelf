import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:backoffice/blocs/blocs.dart';
import 'package:backoffice/models/models.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({required this.user}): super();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BackOffice'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Welcome, ${user.email}',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  authBloc.add(UserLoggedOut());
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}