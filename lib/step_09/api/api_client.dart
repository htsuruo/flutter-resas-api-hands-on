// ignore_for_file: avoid_classes_with_only_static_members, avoid_dynamic_calls

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../env.dart';
import 'api_exception.dart';

class ApiClient {
  static const _host = 'opendata.resas-portal.go.jp';
  static const _headers = {
    'X-API-KEY': Env.resasApiKey,
  };

  Future<T> fetchAndDecodeResult<T>({
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

  (String message, String description) _decodeException(
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
