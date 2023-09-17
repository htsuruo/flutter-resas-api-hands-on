import 'package:flutter/material.dart';
import 'package:flutter_resas_api_hands_on/api.dart';
import 'package:intl/intl.dart';

import '../widgets/widgets.dart';
import 'city.dart';

typedef YearAndValue = (int year, int value);

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key, required this.city});

  final City city;

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late Future<List<YearAndValue>> _municipalityTaxesFuture;

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
      body: FutureBuilder<List<YearAndValue>>(
        future: _municipalityTaxesFuture,
        builder: (context, snapshot) {
          return switch (snapshot.connectionState) {
            ConnectionState.done => snapshot.hasData
                ? _ListViewWithLabel(values: snapshot.data!)
                : CenteredErrorText(error: snapshot.error!),
            _ => const CenteredCircularProgressIndicator(),
          };
        },
      ),
    );
  }
}

class _ListViewWithLabel extends StatelessWidget {
  const _ListViewWithLabel({required this.values});

  final List<YearAndValue> values;

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
              for (final (year, value) in values)
                ListTile(
                  title: Text('$year年'),
                  trailing: _ValueText(value: value),
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
