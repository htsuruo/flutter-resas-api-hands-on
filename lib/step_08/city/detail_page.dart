import 'package:flutter/material.dart';
import 'package:flutter_resas_api_hands_on/widgets/widgets.dart';
import 'package:intl/intl.dart';

import '../api_client.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.cityName),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primaryContainer,
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
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    final taxes = snapshot.data!;
                    return ListView.separated(
                      itemCount: taxes.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final tax = taxes[index];
                        return ListTile(
                          title: Text('${tax.year}年'),
                          trailing: _FormattedTaxText(tax: tax.value),
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
          ),
        ],
      ),
    );
  }
}

class _FormattedTaxText extends StatelessWidget {
  const _FormattedTaxText({required this.tax});

  final int tax;

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTaxLabel(tax),
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  // 千円単位の税金を表示するためのフォーマットを行います
  String _formatTaxLabel(int value) {
    final formatted = NumberFormat('#,###').format(value * 1000);
    return '$formatted円';
  }
}
