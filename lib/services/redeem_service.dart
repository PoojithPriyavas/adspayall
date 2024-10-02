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
import 'package:http/http.dart' as http;

class RedeemService {
  final String baseUrl = "https://adspayall.empyef.com/source/redeem-apacode";

  Future<String> postApaCode(String apaCode, String token) async {
    log("token is $token");
    final url = Uri.parse(baseUrl);

    // Headers
    final headers = {
      "Content-Type": "application/json",
      "Token": "Bearer $token",
    };

    // Body
    final body = jsonEncode({
      "apaCode": apaCode,
    });

    try {
      // Make POST request
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      // Parse response
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        int statusCode = responseBody['status'];

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
        print("not success");
        return "failed";
      }
    } catch (error) {
      throw Exception('Failed to post data: $error');
    }
  }
}
