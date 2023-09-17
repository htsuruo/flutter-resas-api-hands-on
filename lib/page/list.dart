import 'package:flutter/material.dart';
import 'package:flutter_resas_api_hands_on/api.dart';

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
  late final Future<List<City>> _citiesFuture = ApiClient.fetchCities();

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
                final exception = snapshot.error! as ApiException;
                return Center(
                  child: Text(
                    '${exception.message}\n${exception.description}',
                    textAlign: TextAlign.center,
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
