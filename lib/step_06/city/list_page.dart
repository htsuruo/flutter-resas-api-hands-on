import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_resas_api_hands_on/env.dart';
import 'package:http/http.dart' as http;

import 'city.dart';
import 'detail_page.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<String> _citiesFuture;

  @override
  void initState() {
    super.initState();

    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/cities';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
    final param = {
      'prefCode': '14',
    };

    _citiesFuture = http
        .get(
          Uri.https(host, endpoint, param),
          headers: headers,
        )
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder<String>(
        future: _citiesFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final json = jsonDecode(snapshot.data!)['result'] as List;
              final items = json.cast<Map<String, dynamic>>();
              final cities = items.map(City.fromJson).toList();
              return ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return ListTile(
                    title: Text(city.cityName),
                    subtitle: Text(city.cityType.label),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) => CityDetailPage(
                            city: city,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
