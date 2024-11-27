import 'package:flutter/material.dart';
import 'package:flutter_resas_api_hands_on/step_0/city_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter RESAS App',
      home: CityListPage(),
    );
  }
}
