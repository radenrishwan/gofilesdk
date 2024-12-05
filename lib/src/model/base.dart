/// Base response class, used to wrap the response from the server.
class BaseResponse<T> {
  final String status;
  final T data;

  BaseResponse({required this.status, required this.data});

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return BaseResponse(
      status: json['status'],
      data: fromJsonT(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data};
  }

  @override
  String toString() {
    return 'BaseResponse{status: $status, data: $data}';
  }
}
