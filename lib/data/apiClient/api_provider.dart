import 'dart:convert';

import 'package:demo_app/core/utils/logger.dart';
import 'package:demo_app/core/utils/progress_dialog_utils.dart';
import 'package:http/http.dart' as http;

class ApiProvider {

///////////// POST API provider

  Future<dynamic> post(String url, dynamic body,
      [Map<String, String>? headers]) async {
      try {
        final uri = Uri.parse(url);
        if (headers == null || headers.isEmpty) {
          headers = {'Content-Type': 'application/json'};
        }
        var response = await http.post(uri, headers: headers, body: body);
        ProgressDialogUtils.hideProgressDialog();
        return _response(response);
      } catch (error, stackTrace) {
        ProgressDialogUtils.hideProgressDialog();
        Logger.log(error, stackTrace: stackTrace);
      }
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 401:
        // throw UnauthorisedException(response.body.toString());
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 500:
        return json.decode(response.body.toString());

      default:
        print(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
