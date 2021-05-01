import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:backoffice/cubits/cubits.dart';
import 'package:backoffice/layout/layout.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with RestorationMixin {
  final RestorableTextEditingController _emailController = RestorableTextEditingController();
  final RestorableTextEditingController _passwordController = RestorableTextEditingController();

  @override
  String get restorationId => 'login_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_emailController, restorationId);
    registerForRestoration(_passwordController, restorationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: _MainView(
        emailController: _emailController.value,
        passwordController: _passwordController.value,
      ),
    );
  }

  @override
  void dispose () {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class _MainView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _MainView({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  void _login (BuildContext context) {
    context.read<AuthenticationCubit>().login(emailController.text, passwordController.text);
  }

  void _showError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Theme.of(context).errorColor,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    List<Widget> listViewChildren;

    if (isDesktop) {
      final desktopMaxWidth = 400.0 + 100.0 * (cappedTextScale(context) - 1);
      listViewChildren = [
        _EmailInput(
          maxWidth: desktopMaxWidth,
          emailController: emailController,
        ),
        const SizedBox(height: 12),
        _PasswordInput(
          maxWidth: desktopMaxWidth,
          passwordController: passwordController,
        ),
        _LoginFooter(
          maxWidth: desktopMaxWidth,
          onTap: () {
            _login(context);
          },
        ),
      ];
    } else {
      listViewChildren = [];
    }

    return BlocListener<AuthenticationCubit, AuthenticationState> (
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          _showError(context, state.message);
        }
      },
      child: Column(
        children: [
          if (isDesktop) const _TopBar(),
          Expanded(
              child: Align(
                alignment: isDesktop ? Alignment.center : Alignment.topCenter,
                child: ListView(
                  restorationId: 'login_list_view',
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: listViewChildren,
                ),
              ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'BackOffice',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 35 / reducedTextScale(context),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final double? maxWidth;
  final TextEditingController emailController;

  const _EmailInput({
    Key? key,
    this.maxWidth,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: BlocBuilder<AuthenticationCubit, AuthenticationState> (
          builder: (context, state) {
            return TextField(
              textInputAction: TextInputAction.next,
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                errorText: state is AuthenticationErrors ? state.errors['email'] : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final double? maxWidth;
  final TextEditingController passwordController;

  const _PasswordInput({
    Key? key,
    this.maxWidth,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: BlocBuilder<AuthenticationCubit, AuthenticationState> (
          builder: (context, state) {
            return TextField(
              textInputAction: TextInputAction.next,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: state is AuthenticationErrors ? state.errors['password'] : null,
              ),
              obscureText: true,
            );
          },
        ),
      ),
    );
  }
}

class _LoginFooter extends StatelessWidget {
  final double? maxWidth;
  final VoidCallback onTap;

  const _LoginFooter({
    Key? key,
    this.maxWidth,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: BlocBuilder<AuthenticationCubit, AuthenticationState> (
          builder: (context, state) {
            return Row(
              children: [
                if (state is AuthenticationLoading) CircularProgressIndicator(),
                const Expanded(child: SizedBox.shrink()),
                _LoginButton(
                  text: 'Login',
                  onTap: onTap,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _LoginButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: BackOfficeColors.buttonColor,
        primary: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          const Icon(Icons.lock),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }
}