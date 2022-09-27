import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../local/LocalStorage.dart';

class ApiProvider {
  final String _baseUrl = "https://quizu.okoul.com/";

  LocalStorage storage = LocalStorage();

  var mainToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjYzMzU4NDY1fQ.LlVAcArd2Bn3gtdanoHlfMOsHn0gRMqvVHozUk4bjWM";

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url), headers: buildHeaders());
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {Map<String, String>? headers, required String body}) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), headers: buildHeaders2(), body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        Logger().d("responseJson ---> ${responseJson}");

        // print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        Logger().d("responseJson ---> ${responseJson}");

        // print(responseJson);
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

  Map<String, String> buildHeaders({String? token}) {
    var headerToken = "";

    if (token == null) {
      headerToken = storage.read(key: TOKEN);
      Logger().d(": $headerToken");
    } else {
      headerToken = token;
    }

    Map<String, String> headers = {};
    headers["Content-Type"] = "application/json";
    headers["Accept"] = "application/json";
    headers["Access-Control_Allow_Origin"] = "*";
    headers["Authorization"] = "Bearer $headerToken";
    return headers;
  }

  Map<String, String> buildHeaders2() {
    var headerToken = "";
    headerToken = storage.read(key: TOKEN) ?? mainToken;
    Logger().d(": $headerToken");

    Map<String, String> headers = {};
    headers["Content-Type"] = "application/json";
    headers["Accept"] = "application/json";
    headers["Access-Control_Allow_Origin"] = "*";
    headers["Authorization"] = "Bearer $headerToken";
    return headers;
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
