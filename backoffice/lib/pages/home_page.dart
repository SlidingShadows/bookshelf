import 'package:backoffice/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final String token;

  const HomePage({required this.token}): super();

  @override
  Widget build(BuildContext context) {
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
                'Welcome, $token',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().logout();
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