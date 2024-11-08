class AuthResponseModel {
  final int? statusCode;
  final String? message;
  final String? accessToken;
  final int? loginTime;
  final int? expirationDuration;

  AuthResponseModel({
    this.statusCode,
    this.message,
    this.accessToken,
    this.loginTime,
    this.expirationDuration,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // Create an instance of AuthResponseModel from a JSON map
    return AuthResponseModel(
      // Extract the status code from the JSON map
      statusCode: json['statusCode'],
      // Extract the message from the JSON map
      message: json['message'],
      // Extract the access token from the JSON map
      accessToken: json['accessToken'],
      // Extract the login time from the JSON map
      loginTime: json['loginTime'],
      // Extract the expiration duration from the JSON map
      expirationDuration: json['expirationDuration'],
    );
  }
}
