import 'dart:convert';
import 'dart:io';

import 'package:gofilesdk/src/model/create_folder.dart';
import 'package:gofilesdk/src/model/list_server.dart';
import 'package:gofilesdk/src/model/update_attribute.dart';
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

    if (fileName.isEmpty) {
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

  /// Create a new folder. It will throw an exception if the token is not set.
  ///
  /// Parameters:
  /// - [parentFolderId] : The parent folder id.
  /// - [folderName] : The folder name. If not provided, the system will generate a unique folder name automatically.
  Future<BaseResponse<CreateFolderResponse>> createFolder({
    required String parentFolderId,
    String folderName = '',
  }) async {
    if (token.isEmpty) {
      throw Exception('Token is required to create a folder');
    }

    final url = Uri.parse('$BASE_URL/contents/createFolder');

    try {
      final request = await http.post(url, headers: {
        "Authorization": "Bearer $token",
      }, body: {
        "parentFolderId": parentFolderId,
        "folderName": folderName,
      });

      if (request.statusCode == 200) {
        return BaseResponse.fromJson(
          json.decode(request.body),
          (data) => CreateFolderResponse.fromJson(data),
        );
      } else {
        throw Exception(
            'Failed to load data, status code: ${request.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data, error: $e');
    }
  }

  /// Update attribute of a file or folder. It will throw an exception if the token is not set.
  /// You can only change name attribute for a files. If you try to change another attribute, it will throw an error from server.
  /// Refer to https://gofile.io/api
  Future<BaseResponse<UpdateAttributeResponse>> updateAttribute<T>({
    required UpdateAttributeField attribute,
    required String attributeId,
    required T value,
  }) async {
    if (token.isEmpty) {
      throw Exception('Token is required to update attribute');
    }

    switch (attribute) {
      case UpdateAttributeField.name:
      case UpdateAttributeField.description:
      case UpdateAttributeField.tags:
      case UpdateAttributeField.password:
        if (value is! String) {
          throw ArgumentError('Value must be a String for ${attribute.name}');
        }

        break;
      case UpdateAttributeField.public:
        if (value is! bool) {
          throw ArgumentError('Value must be a bool for ${attribute.name}');
        }

        break;
      case UpdateAttributeField.expiry:
        if (value is! int) {
          throw ArgumentError('Value must be an int for ${attribute.name}');
        }

        break;
    }

    final url = Uri.parse('$BASE_URL/contents/$attributeId/update');

    try {
      final request = await http.put(url, headers: {
        "Authorization": "Bearer $token",
      }, body: {
        "attribute": attribute.name,
        "attributeValue": value.toString(),
      });

      if (request.statusCode == 200) {
        return BaseResponse.fromJson(
          json.decode(request.body),
          (data) => UpdateAttributeResponse(),
        );
      } else {
        throw Exception(
            'Failed to load data, status code: ${request.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data, error: $e');
    }
  }

  /// Delete a file or folder. It will throw an exception if the token is not set.
  /// For a multiple delete, you can seperate by using ","
  ///
  /// Warning: Deleting a folder will also remove all its contents, including subfolders and files.
  Future<BaseResponse<ListServerResponse>> delete(
      {required List<String> contentsId}) async {
    if (token.isEmpty) {
      throw Exception('Token is required to delete a file or folder');
    }

    final ids = contentsId.join(',');

    try {
      final response =
          await http.delete(Uri.parse('$BASE_URL/contents'), headers: {
        "Authorization": "Bearer $token",
      }, body: {
        "contentsId": ids,
      });
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
}
