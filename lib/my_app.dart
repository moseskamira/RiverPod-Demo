import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/l10n/l10n.dart';
import 'ui/app_routes/go_router.dart';

class MyApp extends StatelessWidget {
  final String appTitle;
  MyApp({super.key, required this.appTitle});

  final ThemeData _appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  );
  static const List<LocalizationsDelegate> _localizationDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: _appTheme,
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      backButtonDispatcher: appRouter.backButtonDispatcher,
      routeInformationProvider: appRouter.routeInformationProvider,
      supportedLocales: L10n.allLocals,
      locale: const Locale('en'),
      localizationsDelegates: _localizationDelegates,
    );
  }
}
