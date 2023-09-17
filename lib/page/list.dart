import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../model/city.dart';
import 'detail.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({
    super.key,
  });

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<List<City>> _citiesFuture;

  @override
  void initState() {
    super.initState();
    _citiesFuture = http.get(
      Uri.https('opendata.resas-portal.go.jp', '/api/v1/cities'),
      headers: {
        'X-API-KEY': Env.resasApiKey,
      },
    ).then((res) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final result =
          (body['result'] as List).map((res) => res as Map<String, dynamic>);
      return result.map(City.fromJson).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder(
        future: _citiesFuture,
        builder: (context, snapshot) {
          final state = snapshot.connectionState;
          switch (state) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'データの取得に失敗しました',
                  ),
                );
              }
              return _ListView(cities: snapshot.data!);
          }
        },
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({required this.cities});

  final List<City> cities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        return ListTile(
          title: Text(city.cityName),
          subtitle: Text(city.cityCode),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => CityDetailPage(city: city),
              ),
            );
          },
        );
      },
    );
  }
}
