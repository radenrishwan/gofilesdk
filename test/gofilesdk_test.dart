import 'dart:io';

import 'package:gofilesdk/gofilesdk.dart';
import 'package:gofilesdk/src/model/update_attribute.dart';
import 'package:test/test.dart';

void main() {
  test('Get Server', () async {
    final sdk = GofileSDK();
    final result = await sdk.getListServer();

    for (var server in result.data.servers!) {
      print("got server: $server");
    }

    for (var server in result.data.serversAllZone!) {
      print("got server all zone: $server");
    }
  });

  test('Upload File', () async {
    final sdk = GofileSDK(token: "oriP176qGgUbsQYX5UBILhLy0MWNJrTR");

    final file = File('foo.txt');

    final result = await sdk.uploadFile(
      file: file,
      server: 'store3',
      fileName: 'foo.txt',
    );

    print('Upload result: $result');
  });

  test('Create Folder', () async {
    final sdk = GofileSDK(token: "oriP176qGgUbsQYX5UBILhLy0MWNJrTR");

    final result = await sdk.createFolder(
      parentFolderId: 'ddf098a3-d890-4498-86a4-f66001617dbf',
      folderName: 'test folder',
    );

    print('Upload result: $result');
  });

  test('Update Attribute', () async {
    final sdk = GofileSDK(token: "oriP176qGgUbsQYX5UBILhLy0MWNJrTR");

    final result = await sdk.updateAttribute(
      attribute: UpdateAttributeField.name,
      attributeId: 'd30e99d1-d4f1-4354-b3b6-3e67d4dbd99e',
      value: 'new name',
    );

    print('Upload result: $result');
  });

  test('Update Attribute Folder', () async {
    final sdk = GofileSDK(token: "oriP176qGgUbsQYX5UBILhLy0MWNJrTR");

    print("Renaming folder...");
    final resultRename = await sdk.updateAttribute(
      attribute: UpdateAttributeField.name,
      attributeId: '951d807d-4795-416e-9979-7bc82bad5826',
      value: 'new folder name',
    );

    print('Upload result: $resultRename');

    print("Set Expired...");

    final resultExpiry = await sdk.updateAttribute(
      attribute: UpdateAttributeField.expiry,
      attributeId: '951d807d-4795-416e-9979-7bc82bad5826',
      value: 1733299170,
    );

    print('Upload result: $resultExpiry');

    print("Set Public...");
    final resultPublic = await sdk.updateAttribute(
      attribute: UpdateAttributeField.public,
      attributeId: '951d807d-4795-416e-9979-7bc82bad5826',
      value: true,
    );

    print('Upload result: $resultPublic');
  });

  test('Delete Files', () async {
    final sdk = GofileSDK(token: "oriP176qGgUbsQYX5UBILhLy0MWNJrTR");

    final result = await sdk.delete(
      contentsId: ["1d08d330-bb16-40f2-b34a-d1126f56808e"],
    );

    print('Upload result: $result');
  });
}
