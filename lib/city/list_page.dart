import 'package:flutter/material.dart';
import 'package:flutter_resas_api_hands_on/api.dart';

import 'city.dart';
import 'detail_page.dart';

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
    _citiesFuture = ApiClient.fetchCities();
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
              if (snapshot.hasData) {
                return _ListView(cities: snapshot.data!);
              }
              final error = snapshot.error;
              if (error is ApiException) {
                return Center(
                  child: Text(
                    '${error.message}\n${error.description}',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              );
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
