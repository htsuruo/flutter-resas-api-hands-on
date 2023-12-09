import '../../api/api_client.dart';
import '../city/city.dart';
import 'annual_municipality_tax.dart';

class MunicipalityRepository {
  MunicipalityRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  // 市区町村別の一人当たり地方税推移を取得するAPIを叩きます。
  // ref. https://opendata.resas-portal.go.jp/docs/api/v1/municipality/taxes/perYear.html
  Future<List<AnnualMunicipalityTax>> fetchMunicipalityTaxes({
    required City city,
  }) async {
    final result = await _apiClient.fetchAndDecodeResult<Map<String, dynamic>>(
      endpoint: 'api/v1/municipality/taxes/perYear',
      params: {
        'prefCode': city.prefCode.toString(),
        'cityCode': city.cityCode,
      },
    );
    return (result['data'] as List)
        .cast<Map<String, dynamic>>()
        .reversed
        .map(AnnualMunicipalityTax.fromJson)
        .toList();
  }
}
