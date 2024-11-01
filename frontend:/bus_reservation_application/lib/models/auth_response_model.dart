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
    return AuthResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      accessToken: json['accessToken'],
      loginTime: json['loginTime'],
      expirationDuration: json['expirationDuration'],
    );
  }
}
