import 'package:flutter/material.dart';
import 'package:flutter_gps/ui/home.dart';
import 'package:flutter_gps/ui/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gps/app_localizations.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/home",
    supportedLocales: [
      Locale('en', 'US')
    ],
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    localeResolutionCallback: (locale, supportedLocales) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
          return supportedLocale;
        }
      }

      return supportedLocales.first;
    },
    routes: {
      "/splash": (context) => Splash(),
      "/home": (context) => Home()
    },
  ));
}
