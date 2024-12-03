<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Gofile SDK

Unofficial Gofile SDK for Dart and Flutter. still not finish yet because the some api not work now (based on [Gofile Twitter](https://x.com/Gofile_io/status/1852412567903191176), there is some issue with the server )

## Features

all features from Gofile API

## Getting started

didn't need any configuration, just install the package and use it.

## Usage

you can use this package by creating a `GofilSDK` class.

```dart
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

  // for more information, you can see the example folder
}
```

## Additional information

all information about the Gofile API can be found [here](https://gofile.io/api)
