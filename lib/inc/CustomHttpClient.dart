import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lumineux_rewards_app/BaseConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MHttpClient {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  MHttpClient(this.client, this.sharedPreferences);

  get developer => null;

  Future<http.Response> get({
    String path = "",
    // required Map<dynamic, dynamic> extraHeaders
  }) async {
    printWrapped('get Path: $path');
    final response = await client.get(
      Uri.parse(getBaseURL() + path),
      // headers: getHeaders(extraHeaders: extraHeaders),
    );
    printWrapped("get response : \n${utf8.decode(response.bodyBytes)}");
    return response;
  }

  Future<http.Response> post({
    String body = "",
    String path = "",
    // required Map<dynamic, dynamic> extraHeaders
  }) async {
    printWrapped('sent body: \n');
    printWrapped(' ${json.decode(body)}');
    final response = await client.post(
      Uri.parse(getBaseURL() + path),
      body: body,
      // headers: getHeaders(extraHeaders: extraHeaders),
    );
    printWrapped("post response : \n${utf8.decode(response.bodyBytes)}");
    return response;
  }

  Future<http.Response> put({String body = "", String path = ""}) async {
    printWrapped('put body: \n ${json.decode(body)}');
    final response = await client.put(
      Uri.parse(getBaseURL() + path),
      body: body,
      // headers: getHeaders(extraHeaders: extraHeaders),
    );
    printWrapped(utf8.decode(response.bodyBytes));
    return response;
  }

  Future<http.Response> putImage(
      {required File image, String path = ""}) async {
    printWrapped('Image Path: $path');
    final response = await http.put(
      Uri.parse(path),
      headers: getImageHeaders(),
      body: image.readAsBytesSync(),
    );
    return response;
  }

  String getBaseURL() {
    if (kDebugMode) {
      return BaseConstants.baseStagingUrl;
    } else {
      return BaseConstants.baseUrl;
    }
  }

  // String getApiKey() {
  //   if (Foundation.kDebugMode)
  //     return ApiKeyStaging;
  //   else
  //     return ApiKey;
  // }

  // String getToken() {
  //   String? cashedToken = sharedPreferences.getString(CACHED_TOKEN);
  //   cashedToken ??= "";
  //   return cashedToken;
  // }

  // Map<String, String> getHeaders({ Map extraHeaders}) {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     // 'x-api-key': getApiKey(),
  //     // HttpHeaders.authorizationHeader: 'Bearer ${getToken()}',
  //   };
  //   if (extraHeaders.isEmpty) {
  //     return headers;
  //   } else {
  //     headers.addAll(extraHeaders);
  //     return headers;
  //   }
  // }

  Map<String, String> getImageHeaders() {
    return <String, String>{'Content-Type': 'image/png'};
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{400}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => developer.log(match.group(0)));
  }
}
