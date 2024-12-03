import 'dart:io';

import 'package:gofilesdk/gofilesdk.dart';

void main() async {
  final sdk = GofileSDK();

  // you can simply call the function like this
  var listServer = await sdk.getListServer();
  print('Server available: $listServer');

  // upload file
  final file = File('foo.txt');

  var upload = await sdk.uploadFile(
    file: file,
    server: 'store3',
    fileName: 'foo.txt',
  );

  print('Upload result: $upload');
}
