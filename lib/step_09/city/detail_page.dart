import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/api_client.dart';
import '../widgets/widgets.dart';
import 'annual_municipality_tax.dart';
import 'city.dart';

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key, required this.city});

  final City city;

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late Future<List<AnnualMunicipalityTax>> _municipalityTaxesFuture;

  @override
  void initState() {
    super.initState();
    _municipalityTaxesFuture = ApiClient.fetchMunicipalityTaxes(
      city: widget.city,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(widget.city.cityName)),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: colorScheme.primaryContainer,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                '一人当たり地方税',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<AnnualMunicipalityTax>>(
              future: _municipalityTaxesFuture,
              builder: (context, snapshot) {
                return switch (snapshot.connectionState) {
                  ConnectionState.done => snapshot.hasData
                      ? ListView(
                          children: [
                            for (final tax in snapshot.data!)
                              ListTile(
                                title: Text('${tax.year}年'),
                                trailing: _ValueText(value: tax.value),
                              ),
                          ],
                        )
                      : CenteredErrorText(error: snapshot.error!),
                  _ => const CenteredCircularProgressIndicator(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueText extends StatelessWidget {
  const _ValueText({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      '${NumberFormat('#,###').format(value * 1000)}円',
      style: theme.textTheme.bodyLarge,
    );
  }
}
