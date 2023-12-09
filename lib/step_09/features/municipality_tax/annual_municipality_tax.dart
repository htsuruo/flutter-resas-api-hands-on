class AnnualMunicipalityTax {
  AnnualMunicipalityTax({
    required this.year,
    required this.value,
  });

  factory AnnualMunicipalityTax.fromJson(Map<String, dynamic> json) {
    return AnnualMunicipalityTax(
      year: json['year'] as int,
      value: json['value'] as int,
    );
  }

  int year;
  int value;
}
