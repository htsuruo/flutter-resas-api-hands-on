enum CityType {
  /// 一般の市区町村
  general('一般の市区町村'),

  /// 政令指定都市の区
  designatedWard('政令指定都市の区'),

  /// 政令指定都市の市
  designatedCity('政令指定都市の市'),

  /// 東京都23区
  designatedTokyoWard('東京都23区'),
  ;

  const CityType(this.label);
  final String label;
}
