# Generic Json Parser

Generic utility library for parsing `json` including background parsing using `compute()` function.

## Features

- Parsing `json` data list.
- Parsing `json` data object.
- Parsing `json` data list in background.
- Parsing `json` data object in background.

## Usage

1. Add package dependency to `pubspec.yaml`.

```yaml
dependencies:
  generic_json_parser: ^0.0.1
```

2. Import package

```dart
import 'package:generic_json_parser/generic_json_parser.dart';
```

3. Create your model

```dart
class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

```

4. Use one of utility function you like as following.

Using `http` package.

```dart
Future<List<Photo>> fetchPhotos(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    return GenericJsonParser.parseJsonListInBackground(
      responseBody,
      Photo.fromJson,
    );
}
```

Using `dio` package.

```dart
Future<List<Photo>> fetchPhotos(Dio client) async {
    final response = await client
        .getUri(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    return GenericJsonParser.parseJsonListInBackground(
      responseBody,
      Photo.fromJson,
      useDioPackage: true,
    );
}
```
