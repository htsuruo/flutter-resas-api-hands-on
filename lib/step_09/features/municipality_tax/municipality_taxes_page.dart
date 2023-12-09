import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/api_client.dart';
import '../../widgets/widgets.dart';
import '../city/city.dart';
import 'annual_municipality_tax.dart';

class MunicipalityTaxesPage extends StatefulWidget {
  const MunicipalityTaxesPage({super.key, required this.city});

  final City city;

  @override
  State<MunicipalityTaxesPage> createState() => _MunicipalityTaxesPageState();
}

class _MunicipalityTaxesPageState extends State<MunicipalityTaxesPage> {
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
