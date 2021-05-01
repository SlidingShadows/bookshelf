import 'package:backoffice/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:backoffice/config/config.dart';
import 'package:backoffice/cubits/cubits.dart';
import 'package:backoffice/layout/layout.dart' as layout;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  BackOfficeConfig(
      authority: 'localhost:44332',
      useHttps: true,
  );
  
  runApp(BackOffice.makeIt());
}

class BackOffice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'backoffice',
      title: 'BackOffice',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSuccess) {
            return HomePage(token: state.token);
          }

          return LoginPage();
        },
      )
    );
  }

  static Widget makeIt () {
    return BlocProvider<AuthenticationCubit>(
      create: (context) => AuthenticationCubit(),
      child: BackOffice(),
    );
  }
}

ThemeData _buildTheme () {
  final base = ThemeData.dark();

  return ThemeData(
    appBarTheme: const AppBarTheme(
      brightness: Brightness.dark,
      elevation: 0,
    ),
    scaffoldBackgroundColor: layout.BackOfficeColors.primaryBackground,
    primaryColor: layout.BackOfficeColors.primaryBackground,
    focusColor: layout.BackOfficeColors.focusColor,
    textTheme: _buildTextTheme(base.textTheme),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: layout.BackOfficeColors.gray,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: layout.BackOfficeColors.inputBackground,
      focusedBorder: InputBorder.none,
    ),
    visualDensity: VisualDensity.standard,
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    bodyText2: GoogleFonts.robotoCondensed(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: layout.letterSpacingWorkAround(0.5),
    ),
    bodyText1: GoogleFonts.robotoCondensed(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: layout.letterSpacingWorkAround(1.4),
    ),
    button: GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.w700,
      letterSpacing: layout.letterSpacingWorkAround(2.8),
    ),
    headline5: GoogleFonts.robotoCondensed(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      letterSpacing: layout.letterSpacingWorkAround(1.4),
    ),
  ).apply(
    displayColor: Colors.white,
    bodyColor: Colors.white,
  );
}