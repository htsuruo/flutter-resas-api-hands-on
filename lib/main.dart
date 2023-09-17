import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

class CityListPage extends StatelessWidget {
  const CityListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: const Text('text'),
            subtitle: const Text('text'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const CityDetailPage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CityDetailPage extends StatelessWidget {
  const CityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('市区町村詳細')),
    );
  }
}
