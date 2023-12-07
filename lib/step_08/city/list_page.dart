import 'package:flutter/material.dart';
import 'package:flutter_resas_api_hands_on/step_08/api_client.dart';

import '../widgets/centered_circular_progress_indicator.dart';
import 'city.dart';
import 'detail_page.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<List<City>> _citiesFuture;

  @override
  void initState() {
    super.initState();
    _citiesFuture = ApiClient.fetchCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder<List<City>>(
        future: _citiesFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // 本来はhasErrorで分岐するべきですが割愛
              final cities = snapshot.data!;
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
          return const CenteredCircularProgressIndicator();
        },
      ),
    );
  }
}
