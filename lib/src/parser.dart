import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'types.dart';

/// Json parsing utility functions for `list` and `object`.
class GenericJsonParser {
  /// Generic function for json list.
  ///
  /// Example Usage:
  /// ```
  /// final parsedData = parseJsonList<PhotoDTO>(
  ///   response.data,
  ///   PhotoDTO.fromJson,
  /// );
  /// ```
  ///
  /// `data` - Data list of `response.data` from response.
  ///
  /// `useDioPackage` - If you are using [Dio] package, you must supply `true` value. Default is `false`.
  static List<T> parseJsonList<T, F>(
    dynamic data,
    FromJsonCallback<T, F> fromJson, {
    bool useDioPackage = false,
  }) {
    // ignore: prefer_typing_uninitialized_variables
    var encodedJson;
    if (useDioPackage) {
      encodedJson = jsonEncode(data as List<dynamic>);
    }
    final parsed = jsonDecode(useDioPackage ? encodedJson : data)
        .cast<Map<String, dynamic>>();
    return parsed.map<T>(fromJson).toList();
  }

  /// Generic function for json object.
  ///
  /// Example Usage:
  /// ```dart
  /// final parsedData = parseJsonObject<PhotoDTO>(
  ///   response.data,
  ///   PhotoDTO.fromJson,
  /// );
  /// ```
  ///
  /// `data` - Data object of `response.data` from response.
  ///
  /// `useDioPackage` - If you are using [Dio] package, you must supply `true` value. Default is `false`.
  static T parseJsonObject<T, F>(
    dynamic data,
    FromJsonCallback<T, F> fromJson, {
    bool useDioPackage = false,
  }) {
    // ignore: prefer_typing_uninitialized_variables
    var encodedJson;
    if (useDioPackage) {
      encodedJson = jsonEncode(data);
    }
    final parsed = jsonDecode(useDioPackage ? encodedJson : data);
    return fromJson(parsed);
  }

  /// Parse `json` data list in background using `compute()` function.
  static Future<List<T>> computeParseJsonList<T, D, F>(
    D data,
    FromJsonCallback<T, F> fromJson, {
    bool useDioPackage = false,
  }) {
    return compute(
      (message) => parseJsonList<T, F>(
        message,
        fromJson,
        useDioPackage: useDioPackage,
      ),
      data,
    );
  }

  /// Parse `json` data in background using `compute()` function.
  static Future<T> computeParseJsonObject<T, D, F>(
    D data,
    FromJsonCallback<T, F> fromJson, {
    bool useDioPackage = false,
  }) {
    return compute(
      (message) => parseJsonObject<T, F>(
        message,
        fromJson,
        useDioPackage: useDioPackage,
      ),
      data,
    );
  }
}
