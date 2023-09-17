import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'page/list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Beginners hands-on',
      theme: ThemeData.light(useMaterial3: true),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
      ],
      home: const CityListPage(),
    );
  }
}
