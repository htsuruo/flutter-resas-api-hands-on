// ignore_for_file: avoid_classes_with_only_static_members, avoid_dynamic_calls

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../env.dart';
import 'city/annual_municipality_tax.dart';
import 'city/city.dart';

abstract class ApiClient {
  static const _host = 'opendata.resas-portal.go.jp';
  static final _headers = {
    'X-API-KEY': Env.resasApiKey,
  };

  // 市区町村一覧をGETで取得する
  static Future<List<City>> fetchCities() async {
    final res = await http.get(
      Uri.https(_host, '/api/v1/cities'),
      headers: _headers,
    );
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body)['result'] as List;
      final items = json.cast<Map<String, dynamic>>();
      return items.map(City.fromJson).toList();
    }
    throw Exception('Failed to load cities');
  }

  // 一人当たり地方税をGETで取得する
  static Future<List<AnnualMunicipalityTax>> fetchMunicipalityTaxes({
    required int prefCode,
    required String cityCode,
  }) async {
    final res = await http.get(
      // 第三引数にパラメータを指定できます
      Uri.https(_host, '/api/v1/municipality/taxes/perYear', {
        'prefCode': prefCode.toString(),
        'cityCode': cityCode,
      }),
      headers: _headers,
    );
    if (res.statusCode == 200) {
      final result = jsonDecode(res.body)['result'] as Map<String, dynamic>;
      final data = result['data'] as List;
      final items = data.cast<Map<String, dynamic>>();
      return items
          .map(AnnualMunicipalityTax.fromJson)
          .toList()
          .reversed
          .toList();
    } else {
      throw Exception('Failed to load municipality taxes');
    }
  }
}
