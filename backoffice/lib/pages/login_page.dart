import 'package:backoffice/blocs/blocs.dart';
import 'package:backoffice/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState> (
        builder: (context, state) {
          final authBloc = BlocProvider.of<AuthenticationBloc>(context);

          if (state is AuthenticationNotAuthenticated) {
            return _AuthForm();
          }

          // return splash screen
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
        ),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
            authenticationBloc: authBloc,
            authenticationService: authService,
        ),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState> (
      listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState> (
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Form (
            key: _key,
            autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        filled: true,
                        isDense: true,
                      ),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null) {
                          return 'Email is required';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        isDense: true,
                      ),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null) {
                          return 'Password is required';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      /*color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),*/
                      child: Text('Log in'),
                      onPressed: () {
                        if (state is LoginLoading) {
                          return;
                        }

                        if (_key.currentState?.validate() ?? false) {
                          loginBloc.add(
                              LoginButtonPressed(
                                  email: _emailController.text,
                                  password: _passwordController.text
                              )
                          );
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).errorColor,
      )
    );
  }
}