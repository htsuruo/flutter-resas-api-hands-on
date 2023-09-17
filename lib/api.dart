import 'dart:convert';

import 'package:flutter_resas_api_hands_on/env.dart';
import 'package:flutter_resas_api_hands_on/model/city.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient._();

  static const _host = 'opendata.resas-portal.go.jp';
  static const _headers = {
    'X-API-KEY': Env.resasApiKey,
  };

  // 市区町村の一覧を取得するAPIを叩きます。
  // ref. https://opendata.resas-portal.go.jp/docs/api/v1/cities.html
  static Future<List<City>> fetchCities() async {
    final result = await _fetchAndDecodeResult<List<dynamic>>(
      endpoint: '/api/v1/cities',
    );
    return result
        .map((res) => City.fromJson(res as Map<String, dynamic>))
        .toList();
  }

  // 市区町村別の一人当たり地方税推移を取得するAPIを叩きます。
  // ref. https://opendata.resas-portal.go.jp/docs/api/v1/municipality/taxes/perYear.html
  // static Future<List<City>> fetchMunicipalityTaxes({required City city}) async {
  //   final result = await _fetchAndDecodeResult<Map<String, dynamic>>(
  //     endpoint: 'api/v1/population/sum/estimate',
  //     params: {
  //       'prefCode': city.prefCode.toString(),
  //       'cityCode': city.cityCode,
  //     },
  //   );
  //   final data = (result['data'] as List)
  //       .map((data) => (data['year'] as int, data['value'] as double))
  //       .toList();
  //   return result
  //       .map((res) => City.fromJson(res as Map<String, dynamic>))
  //       .toList();
  // }

  static Future<T> _fetchAndDecodeResult<T>({
    required String endpoint,
    Map<String, dynamic>? params,
  }) async {
    final response = await http.get(
      Uri.https(_host, endpoint, params),
      headers: _headers,
    );
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final statusCode = body['statusCode'] as String?;
    // 成功時は`statusCode`が返ってこないため`null`を許容します。
    if (statusCode == null || statusCode == '200') {
      return body['result'] as T;
    }
    final (message, description) = _decodeException(body);
    throw ApiException(
      statusCode: statusCode,
      message: message,
      description: description,
    );
  }

  static (String message, String description) _decodeException(
    Map<String, dynamic> body,
  ) {
    if (body
        case {
          'message': final String message,
          'description': final String description,
        }) {
      return (message, description);
    } else {
      throw const FormatException('Unexpected JSON');
    }
  }
}

class ApiException implements Exception {
  const ApiException({
    required this.statusCode,
    required this.message,
    required this.description,
  });

  final String statusCode;
  final String message;
  final String description;
}
