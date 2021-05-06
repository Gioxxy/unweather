class ResponseError {
  String cod;
  String message;

  ResponseError.serviceConstructor(this.cod, this.message);

  factory ResponseError.fromJson(Map<String, dynamic> json) {
    return ResponseError.serviceConstructor(
      json['cod'] ?? "500",
      json['message'] ?? "",
    );
  }
}