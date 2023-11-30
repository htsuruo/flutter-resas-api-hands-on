class City {
  City({
    required this.prefCode,
    required this.cityCode,
    required this.cityName,
    required this.bigCityFlag,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      prefCode: json['prefCode'] as int,
      cityCode: json['cityCode'] as String,
      cityName: json['cityName'] as String,
      bigCityFlag: json['bigCityFlag'] as String,
    );
  }

  int prefCode;
  String cityCode;
  String cityName;
  String bigCityFlag;

  // ref. https://dart.dev/language/operators
  @override
  bool operator ==(Object other) {
    return other is City &&
        other.prefCode == prefCode &&
        other.cityCode == cityCode &&
        other.cityName == cityName &&
        other.bigCityFlag == bigCityFlag;
  }

  @override
  int get hashCode;
}
