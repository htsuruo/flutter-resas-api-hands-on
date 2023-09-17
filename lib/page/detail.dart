import 'package:flutter/material.dart';
import 'package:flutter_resas_api_hands_on/model/city.dart';

class CityDetailPage extends StatelessWidget {
  const CityDetailPage({super.key, required this.city});

  final City city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(city.cityName)),
    );
  }
}
