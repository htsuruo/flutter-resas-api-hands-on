import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/api_client.dart';
import 'annual_municipality_tax.dart';
import 'city.dart';
import 'widgets/widgets.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text(widget.city.cityName)),
      body: FutureBuilder<List<AnnualMunicipalityTax>>(
        future: _municipalityTaxesFuture,
        builder: (context, snapshot) {
          return switch (snapshot.connectionState) {
            ConnectionState.done => snapshot.hasData
                ? _ListViewWithLabel(taxes: snapshot.data!)
                : CenteredErrorText(error: snapshot.error!),
            _ => const CenteredCircularProgressIndicator(),
          };
        },
      ),
    );
  }
}

class _ListViewWithLabel extends StatelessWidget {
  const _ListViewWithLabel({required this.taxes});

  final List<AnnualMunicipalityTax> taxes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          child: ListView(
            children: [
              for (final tax in taxes)
                ListTile(
                  title: Text('${tax.year}年'),
                  trailing: _ValueText(value: tax.value),
                ),
            ],
          ),
        ),
      ],
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
