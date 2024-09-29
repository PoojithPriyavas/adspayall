import 'dart:convert'; // For JSON encoding and decoding
import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/shared_pref_data.dart';
import 'package:ads_pay_all/model/login_model.dart';
import 'package:ads_pay_all/model/regster_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl =
      'https://adspayall.empyef.com/source/app-login'; // Replace with your actual API URL
  final SharedPrefData sharedPrefData =
      SharedPrefData(); // Instantiate the SharedPrefData

  Future<LoginResponse?> login(String username, String password) async {
    try {
      final Map<String, dynamic> requestBody = {
        "username": username,
        "password": password
      };

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == 200 &&
            responseData['status_message'] == 'success') {
          // Parse the JSON response into a LoginResponse model object
          LoginResponse loginResponse = LoginResponse.fromJson(responseData);

          // Store the token in SharedPreferences
          sharedPrefData.setToken(loginResponse.data.token);
          print("Token saved to SharedPreferences");
          return loginResponse;
        } else {
          // Handle error response
          print('Error: ${responseData['status_message']}');
          return null;
        }
      } else {
        // Handle server error
        print('Server error with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle exceptions
      print('Failed to login: $e');
      return null;
    }
  }

  // Future<RegisterResponse?> createAccount(
  //     String username, String password) async {
  //   try {
  //     final Map<String, dynamic> requestBody = {
  //       "username": username,
  //       "password": password
  //     };

  //     final http.Response response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(requestBody),
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = jsonDecode(response.body);

  //       if (responseData['status'] == 201 &&
  //           responseData['status_message'] == 'success') {
  //         // Parse the JSON response into a LoginResponse model object
  //         RegisterResponse registerResponse =
  //             RegisterResponse.fromJson(responseData);

  //         return registerResponse;
  //       } else {
  //         // Handle error response
  //         print('Error: ${responseData['status_message']}');
  //         return null;
  //       }
  //     } else {
  //       // Handle server error
  //       print('Server error with status code: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     // Handle exceptions
  //     print('Failed to login: $e');
  //     return null;
  //   }
  // }

  Future<RegisterResponse?> createAccount(
      String username, String password) async {
    try {
      final Map<String, dynamic> requestBody = {
        "username": username,
        "password": password,
      };

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        print("response is ${responseData['status']}");

        if (responseData['status'] == 200) {
          // Registration success
          RegisterResponse registerResponse =
              RegisterResponse.fromJson(responseData);
          return registerResponse;
        } else if (responseData['status'] == 201) {
          // Registered but email failed to send
          print('Registered but email failed to send. Please contact admin.');
          return null;
        } else if (responseData['status'] == 401) {
          // Username/email already exists
          print('Error: Username/email already exists.');
          return null;
        } else if (responseData['status'] == 400) {
          // General error
          print('Error: ${responseData['status_message']}');
          return null;
        }
      } else {
        // Handle server error
        print('Server error with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle exceptions
      print('Failed to register: $e');
      return null;
    }
  }

  Future<bool> forgetPassword(String username, BuildContext context) async {
    try {
      final Map<String, dynamic> requestBody = {
        "username": username,
      };

      final http.Response response = await http.post(
        Uri.parse("https://adspayall.empyef.com/source/forgot-password"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 401 ||
          response.statusCode == 402 ||
          response.statusCode == 403) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        print("response is ${responseData['status']}");

        if (responseData['status'] == 200) {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Successfull'),
                  content:
                      const Text('Password recovery email sent successfully.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'ok',
                        style: TextStyle(color: blackColor),
                      ),
                    )
                  ],
                );
              });
          // Success
          print('Password recovery email sent successfully.');
          return true;
        } else if (responseData['status'] == 401) {
          // Failed to send recovery mail
          print('Failed to send recovery mail. Please try via the website.');

          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Failed'),
                  content: const Text(
                      "Failed to send recovery mail. Please try via the website."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'ok',
                        style: TextStyle(color: blackColor),
                      ),
                    )
                  ],
                );
              });
          return false;
        } else if (responseData['status'] == 402) {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Account not verified'),
                  content: const Text(
                      'Your account is not verified yet. Please verify your account.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'ok',
                        style: TextStyle(color: blackColor),
                      ),
                    )
                  ],
                );
              });
          // Account not verified
          print(
              'Your account is not verified yet. Please verify your account.');
          return false;
        } else if (responseData['status'] == 403) {
          // Username/email doesn't exist
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Invalid EmailId'),
                  content: const Text("Username/email doesn't exist."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'ok',
                        style: TextStyle(color: blackColor),
                      ),
                    )
                  ],
                );
              });
          print("Error: Username/email doesn't exist.");
          return false;
        } else {
          // Handle unexpected status codes in response data
          print('Unexpected response status: ${responseData['status']}');
          return false;
        }
      } else {
        // Handle server error
        print('Server error with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle exceptions
      print('Failed to process forget password request: $e');
      return false;
    }
  }
}


// responseData['status'] =
// 200 success 
// 201 registered but mail failed to send... Contact admin
// 401 username/email already exists
// 400 error
