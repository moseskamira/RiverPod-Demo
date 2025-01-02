import 'package:flutter/material.dart';

import 'app_routes/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Riverpod',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      backButtonDispatcher: router.backButtonDispatcher,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
