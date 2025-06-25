// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;

// class RedeemService {
//   final String baseUrl = "https://adspayall.empyef.com/source/redeem-apacode";

//   Future<http.Response> postApaCode(String apaCode, String token) async {
//     final url = Uri.parse(baseUrl);

//     // Headers
//     final headers = {
//       "Content-Type": "application/json",
//       "Token": "Bearer $token",
//     };

//     // Body
//     final body = jsonEncode({
//       "apaCode": apaCode,
//     });

//     try {
//       // Make POST request
//       final response = await http.post(
//         url,
//         headers: headers,
//         body: body,
//       );
//       log("response is ${response.body}");
//       return response;
//     } catch (error) {
//       throw Exception('Failed to post data: $error');
//     }
//   }
// }

import 'dart:convert';
import 'dart:developer';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class RedeemService {
  final String baseUrl = "https://adspayall.empyef.com/source/redeem-apacode";

  // Future<String> postApaCode(String apaCode, String token) async {
  //   log("token is $token");
  //   final url = Uri.parse(baseUrl);

  //   final completeToken = "Bearer $token";

  //   // Headers
  //   final headers = {
  //     // "Token": "Bearer $token",
  //     "Token": completeToken
  //   };

  //   // Body
  //   final body = jsonEncode({
  //     "apaCode": apaCode,
  //   });

  //   try {
  //     // Make POST request
  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //       body: body,
  //     );

  //     log("complete token is $completeToken");

  //     log("respose is ${response.body}");

  //     // Parse response
  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       int statusCode = responseBody['status'];

  //       switch (statusCode) {
  //         case 200:
  //           return "Success";
  //         case 210:
  //           return "APA Code Already Redeemed";
  //         case 211:
  //           return "Not available for your postcode/zipcode";
  //         case 212:
  //           return "Code Expired";
  //         case 213:
  //           return "Invalid APA Code";
  //         case 214:
  //           return "Incomplete User Profile";
  //         case 401:
  //           return "Not logged in";
  //         default:
  //           return "Network Error";
  //       }
  //     } else {
  //       print("not success");
  //       return "failed";
  //     }
  //   } catch (error) {
  //     throw Exception('Failed to post data: $error');
  //   }
  // }

  Future<String> redeemApacode(String apaCode, String token) async {
    final dio = Dio();

    // The URL for the API
    const String url = 'https://adspayall.empyef.com/source/redeem-apacode';

    // The headers to pass with the request
    final headers = {
      'content-type': 'application/json',
      'token':
          // "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIiLCJyb2xlIjoiMSIsInByb21vdGVyIjoiSTVENU5DSERTTyIsImVtYWlsIjoiY2hyaXN0aG9tYXNwQHlhaG9vLmNvbSJ9.4Plj9Q3uj-f3QSbCJaUwCj3K2vvYPg-0F0p1xhLe6hA",
          "Bearer $token"
    };

    // The body of the request
    final body = {
      // 'apaCode': 'christhomasp@yahoo.com',
      'apaCode': '$apaCode',
    };

    try {
      // Making the POST request using dio
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

      // Check for success
      if (response.statusCode == 200) {
        log("Success: ${response.data}");
        print("Success: ${response.data}");

        final responseBody = jsonDecode(response.data);
        int statusCode = responseBody['status'];

        log("status code is $statusCode");

        switch (statusCode) {
          case 200:
            return "Success";
          case 210:
            return "APA Code Already Redeemed";
          case 211:
            return "Not available for your postcode/zipcode";
          case 212:
            return "Code Expired";
          case 213:
            return "Invalid APA Code";
          case 214:
            return "Incomplete User Profile";
          case 401:
            return "Not logged in";
          default:
            return "Network Error";
        }
      } else {
        log('Failed: ${response.statusCode} - ${response.data}');
        return "failed";
      }
    } catch (e) {
      log('Error: $e');
      return "Error";
    }
  }
}
