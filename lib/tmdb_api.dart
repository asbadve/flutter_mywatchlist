import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'exception.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://api.themoviedb.org/3/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
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
}

//class ApiResponse<T> {
//  Status status;
//  T data;
//  String message;
//
//  ApiResponse.loading(this.message) : status = Status.LOADING;
//  ApiResponse.completed(this.data) : status = Status.COMPLETED;
//  ApiResponse.error(this.message) : status = Status.ERROR;
//
//  @override
//  String toString() {
//    return "Status : $status \n Message : $message \n Data : $data";
//  }
//}
//
//enum Status { LOADING, COMPLETED, ERROR }
