class ResponseError {
  final String code;
  final String description;

  ResponseError(this.code, this.description);

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
    json['code'] as String,
    json['description'] as String,
  );
}