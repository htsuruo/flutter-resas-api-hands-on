// ignore_for_file: avoid_classes_with_only_static_members, avoid_dynamic_calls

import 'package:flutter_resas_api_hands_on/step_09/api/api_client.dart';

import 'city.dart';

class CityRepository {
  CityRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  // 市区町村の一覧を取得するAPIを叩きます。
  // ref. https://opendata.resas-portal.go.jp/docs/api/v1/cities.html
  Future<List<City>> fetchCities() async {
    final result = await _apiClient.fetchAndDecodeResult<List<dynamic>>(
      endpoint: '/api/v1/cities',
    );
    return result.cast<Map<String, dynamic>>().map(City.fromJson).toList();
  }
}
