import 'package:flutter/material.dart';
import 'package:flutter_resas_api_hands_on/env.dart';
import 'package:http/http.dart' as http;

import 'detail_page.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  @override
  void initState() {
    super.initState();

    Future(() async {
      const host = 'opendata.resas-portal.go.jp';
      const endpoint = '/api/v1/cities';
      final headers = {
        'X-API-KEY': Env.resasApiKey,
      };

      final response = await http.get(
        Uri.https(host, endpoint),
        headers: headers,
      );

      print(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cities = [
      '札幌市',
      '横浜市',
      '川崎市',
      '名古屋市',
      '京都市',
      '大阪市',
      '堺市',
      '神戸市',
      '岡山市',
      '広島市',
      '北九州市',
      '福岡市',
      '熊本市',
      '那覇市',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: ListView(
        children: [
          for (final city in cities)
            ListTile(
              title: Text(city),
              subtitle: const Text('政令指定都市'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => CityDetailPage(city: city),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
