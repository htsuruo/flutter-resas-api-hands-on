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
