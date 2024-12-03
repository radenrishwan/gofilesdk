import 'dart:io';

import 'package:gofilesdk/gofilesdk.dart';
import 'package:test/test.dart';

void main() {
  test('Get Server', () async {
    final sdk = GofileSDK();
    final result = await sdk.getListServer();

    for (var server in result.data.servers) {
      print("got server: $server");
    }

    for (var server in result.data.serversAllZone) {
      print("got server all zone: $server");
    }
  });

  test('Upload File', () async {
    final sdk = GofileSDK(token: "");

    final file = File('foo.txt');

    final result = await sdk.uploadFile(
      file: file,
      server: 'store3',
      fileName: 'foo.txt',
    );

    print('Upload result: $result');
  });
}
