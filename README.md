# Gofile SDK

Unofficial Gofile SDK for Dart and Flutter.

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
