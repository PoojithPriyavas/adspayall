class RegisterResponse {
  final int status;
  final String statusMessage;
  final LoginData data;

  RegisterResponse({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  // Factory method to create a new RegisterResponse instance from a map
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'],
      statusMessage: json['status_message'],
      data: LoginData.fromJson(json['data']),
    );
  }

  // Method to convert a LoginResponse instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'status_message': statusMessage,
      'data': data.toJson(),
    };
  }
}



class LoginData {
  final String role;
  final String token;
  final String name;

  LoginData({
    required this.role,
    required this.token,
    required this.name,
  });

  // Factory method to create a new LoginData instance from a map
  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      role: json['r'],
      token: json['token'],
      name: json['name'],
    );
  }

  // Method to convert a LoginData instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'r': role,
      'token': token,
      'name': name,
    };
  }
}
