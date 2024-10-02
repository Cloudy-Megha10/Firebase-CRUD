import 'dart:convert';
import 'dart:io';
import 'package:demo_app/data/apiClient/api_provider.dart';
import 'package:demo_app/data/apiClient/common_response.dart';
import 'package:demo_app/presentation/login_screen/models/login_response.dart';
import 'package:http/http.dart' as http;
import '../../../data/apiClient/url_list.dart';

class LoginRepository {
    ApiProvider _provider = ApiProvider();
  Future<CommonResponse<LoginResponse>> loginUserData(
    String? userName, String? password) async {
  try {
    // Logging username for debugging purposes
    print("userName");
    print(userName);

    // Creating request body
    var body = json.encode({
      "username": userName,
      "password": password,
    });
    print("bodycreate");
    print(body);
    var headers = {
        'Content-Type': 'application/json',
        "api-supported-versions": '1.0',
      };
      final response =
          await _provider.post(UrlList.loginUrl, body, headers);
    print(UrlList.loginUrl);
    print("respone $response");

    // Parsing the response
    LoginResponse res = LoginResponse.fromJson(response);
    print("res $res");
    print("Login successful, response: $res");

    // Wrapping response in CommonResponse
    return CommonResponse(true, res, "Success");
   } on SocketException catch (e) {
    print("Network Error: $e");
    return CommonResponse.withoutData(false, "Network Error: Failed to reach server. Please check your internet connection.");
  } catch (e) {
    print("Error in Catch Block: $e");
    return CommonResponse.withoutData(false, "Failure: $e");
  }
}
}