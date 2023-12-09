import 'package:flutter/material.dart';

import '../../api/api_client.dart';
import '../../widgets/widgets.dart';
import '../municipality_tax/municipality_taxes_page.dart';
import 'city.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({
    super.key,
  });

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
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
          return switch (snapshot.connectionState) {
            ConnectionState.done => snapshot.hasData
                ? _ListView(cities: snapshot.data!)
                : CenteredErrorText(error: snapshot.error!),
            _ => const CenteredCircularProgressIndicator(),
          };
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
          subtitle: Text(city.cityType.label),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => MunicipalityTaxesPage(city: city),
              ),
            );
          },
        );
      },
    );
  }
}
