import 'dart:convert';
import 'dart:io';

import 'package:gofilesdk/src/model/list_server.dart';
import 'package:gofilesdk/src/model/upload_server.dart';
import 'package:http/http.dart' as http;

const BASE_URL = "https://api.gofile.io";

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

class GofileSDK {
  final String token;

  /// Initialize GofileSDK. if the token is not provided, it will use guest token. Refer to https://gofile.io/api
  GofileSDK({this.token = ''});

  /// Get list of server available
  /// Do not call this function more than once for every 10 seconds. If you upload a lot small files, you can use the same server for all of them.
  /// Refer to https://gofile.io/api
  Future<BaseResponse<ListServerResponse>> getListServer() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL/servers'));
      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          json.decode(response.body),
          (data) => ListServerResponse.fromJson(data),
        );
      } else {
        throw Exception(
            'Failed to load data, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data, error: $e');
    }
  }

  /// Upload file to Gofile server.
  ///
  /// Parameters:
  /// - [server] : You can get list server by calling [getListServer]
  /// - [file] : The file to be uploaded
  /// - [fileName] : If the fileName is empty, it will generate random name
  /// - [folderId] : If the folderId is empty, it will be create a new folder and the folder will be public
  Future<BaseResponse<UploadFileResponse>> uploadFile({
    required String server,
    required File file,
    String fileName = '',
    String folderId = '',
  }) async {
    final url = Uri.parse('https://$server.gofile.io/contents/uploadfile');

    var request = http.MultipartRequest('POST', url);

    if (token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    if (folderId.isNotEmpty) {
      request.fields['folderId'] = folderId;
    }

    final fileStream = http.ByteStream(file.openRead());
    final fileLength = file.lengthSync();

    if (fileName.isNotEmpty) {
      fileName = DateTime.now().millisecondsSinceEpoch.toString();
    }

    request.files.add(http.MultipartFile(
      'file',
      fileStream,
      fileLength,
      filename: fileName,
    ));

    try {
      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return BaseResponse.fromJson(
          json.decode(responseString),
          (data) => UploadFileResponse.fromJson(data),
        );
      } else {
        throw Exception(
            'Failed to load data, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data, error: $e');
    }
  }
}
