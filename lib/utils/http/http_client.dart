import 'dart:convert';

import 'package:http/http.dart ' as http;

class MHttpClientHelper {
  static const String _baseUrl =
      "http://your-api-base-url.com"; //Replace with API base url

  //Helper method to make a GET request

  static Future<Map<String, dynamic>> getRequest(String endPoint) async {
    final responce = await http.get(Uri.parse('$_baseUrl/$endPoint'));
    return _handleResponce(responce);
  }

//Helper method to make a POST request
  static Future<Map<String, dynamic>> postRequest(
      String endPoint, dynamic data) async {
    final responce = await http.post(
        Uri.parse(
          '$_baseUrl/$endPoint',
        ),
        headers: {'Content-type': 'application/json'},
        body: json.encode(data));
    return _handleResponce(responce);
  }

  //Helper method to make a PUT request
  static Future<Map<String, dynamic>> putRequest(
      String endPoint, dynamic data) async {
    final responce = await http.put(
        Uri.parse(
          '$_baseUrl/$endPoint',
        ),
        headers: {'Content-type': 'application/json'},
        body: json.encode(data));
    return _handleResponce(responce);
  }

  //Helper method to make a DELETE request
  static Future<Map<String, dynamic>> deleteRequest(String endPoint) async {
    final responce = await http.delete(Uri.parse('$_baseUrl/$endPoint'));
    return _handleResponce(responce);
  }

  //Handle the  HTTP Responce
  static Map<String, dynamic> _handleResponce(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data:${response.statusCode}');
    }
  }
}
