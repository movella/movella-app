import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movella_app/exceptions/invalid_request_exception.dart';
import 'package:movella_app/utils/services/shared_preferences.dart';

const host = '192.168.15.35:4001';

class Api {
  static String get _path => '/api/';

  static Uri _getUri(
    String uri, [
    Map<String, dynamic>? query,
  ]) {
    return Uri.http(host, '$_path$uri', query);
  }

  static Future<Map<String, String>> get getHeaders async {
    return {
      HttpHeaders.authorizationHeader: await Prefs.getAuthorization ?? '',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  static Future get(String uri, [Map<String, String>? query]) async {
    final headers = await getHeaders;

    final response = await http.get(
      _getUri(uri, query),
      headers: headers,
    );

    _log(
      uri: uri,
      response: response,
      method: 'GET',
      headers: headers,
      path: _path,
    );

    await _updateHeaders(response: response);

    final decoded = jsonDecode(response.body);

    return decoded;
  }

  static Future post(
    String uri,
    Map<String, dynamic> body,
  ) async {
    final headers = await getHeaders;

    final response = await http.post(
      _getUri(uri),
      headers: headers,
      body: jsonEncode(body),
    );

    _log(
      uri: uri,
      response: response,
      method: 'POST',
      headers: headers,
      path: _path,
    );

    await _updateHeaders(response: response);

    final decoded = jsonDecode(response.body);

    if (response.statusCode >= 400) {
      throw InvalidRequestException(
        message: decoded['message'] ?? 'Something went wrong',
      );
    }

    return decoded;
  }

  static void _log({
    required String uri,
    required http.Response response,
    required String method,
    required Map<String, String> headers,
    required String path,
  }) {
    if (kDebugMode) {
      print(
        '$method $path$uri ${((response.contentLength ?? 0) / 1000).toStringAsFixed(2)}KB',
      );
      // print(response.body);
    }
  }

  static Future<void> _updateHeaders({required http.Response response}) async {
    final authorization = response.headers['authorization'];

    if (authorization != null) {
      await Prefs.setAuthorization(authorization);
    }
  }
}
