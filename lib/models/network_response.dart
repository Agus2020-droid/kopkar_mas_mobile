enum Status { success, loading, error, timeout, internetError }

class NetworkResponse {
  final Status? status;
  final int? statusCode;
  final Map<String, dynamic>? data;
  final String? message;

  NetworkResponse(
    this.status,
    this.statusCode,
    this.data,
    this.message,
  );

  static NetworkResponse success(data) {
    return NetworkResponse(Status.success, 200, data, null);
  }

  static NetworkResponse error({data, String? message, int? statusCode}) {
    return NetworkResponse(Status.error, statusCode, data, message);
  }

  static NetworkResponse internetError() {
    return NetworkResponse(Status.internetError, null, null, null);
  }
}
