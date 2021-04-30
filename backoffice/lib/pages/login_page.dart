import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:backoffice/cubits/cubits.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocListener<AuthenticationCubit, AuthenticationState> (
          listener: (context, state) {
            if (state is AuthenticationFailure) {
              _showError(state.message);
            }
          },
          child: BlocBuilder<AuthenticationCubit, AuthenticationState> (
            builder: (context, state) {
              if (state is AuthenticationLoading) {
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
                            errorText: state is AuthenticationErrors ? state.errors['email'] : null,
                          ),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (value) {
                            if ((value ?? '') == '') return 'Email is required';
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
                            errorText: state is AuthenticationErrors ? state.errors['password'] : null,
                          ),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if ((value ?? '') == '') return 'Password is required';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          child: Text('Log in'),
                          onPressed: () {
                            if (state is AuthenticationLoading) {
                              return;
                            }

                            if (_key.currentState?.validate() ?? false) {
                              context.read<AuthenticationCubit>().login(_emailController.text, _passwordController.text);
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
        ),
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