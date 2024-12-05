import 'package:gofilesdk/src/model/base.dart';

class DeleteResponse {
  final Map<String, BaseResponse<Map<String, dynamic>>> data;
  final String status;

  DeleteResponse({required this.status, required this.data});

  factory DeleteResponse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> dataMap = json['data'] as Map<String, dynamic>;

    Map<String, BaseResponse<Map<String, dynamic>>> parsedData = dataMap.map(
      (key, value) => MapEntry(
        key,
        BaseResponse<Map<String, dynamic>>.fromJson(
          value as Map<String, dynamic>,
          (data) => data,
        ),
      ),
    );

    return DeleteResponse(
      status: json['status'],
      data: parsedData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  @override
  String toString() {
    return 'DeleteResponse{status: $status, data: $data}';
  }
}
