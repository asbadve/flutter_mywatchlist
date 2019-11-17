import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'exception.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://api.themoviedb.org/3/";

  Future<dynamic> getFromPath(
      String url, Map<String, String> queryParam) async {
    String key = await loadKey();
    String pathUrl = url + key + getQueryParam(queryParam);
    var responseJson;
    try {
      final response = await http
          .get(_baseUrl + pathUrl)
          .timeout(Duration(seconds: 2), onTimeout: _onTimeout);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  FutureOr<http.Response> _onTimeout() {
    throw Exception("timeout");
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  String getQueryParam(Map<String, String> queryParam) {
    String query = "";
    for (int i = 0; i < queryParam.length; i++) {
      String q = "&" +
          queryParam.keys.elementAt(i) +
          "=" +
          queryParam.values.elementAt(i);
      query = query + q;
    }
    return query;
  }
}

Future<String> loadKey() async {
  var asset = await loadAsset();
  String pw;
  try {
    pw = asset.toString();
  } catch (e) {
    debugPrint(e);
  }

  return "?api_key=" + jsonDecode(pw)['tmdb_key'];
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/keys.json');
}
