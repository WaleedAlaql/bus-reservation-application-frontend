import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

int getGrandTotal(int discount, int totalSeatBooked, int price, int fee) {
  final subTotal = (totalSeatBooked * price);
  final priceAfterDiscount = subTotal - ((subTotal * discount) / 100);
  return (priceAfterDiscount + fee).toInt();
}

TimeOfDay getTimeOfDay(String time) {
  final hour = int.parse(time.split(':')[0]);
  final minute = int.parse(time.split(':')[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

Future<bool> saveToken(String token) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.setString(accessToken, token);
}

Future<String?> getToken() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(accessToken);
}

Future<bool> saveLoginTime(int time) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.setInt(loginTime, time);
}

Future<int?> getLoginTime() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getInt(loginTime);
}

Future<bool> saveExpirationDuration(int duration) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.setInt(expirationDuration, duration);
}

Future<int?> getExpirationDuration() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getInt(expirationDuration);
}

Future<bool> hasTokenExpired() async {
  final loginTime = await getLoginTime();
  final expirationDuration = await getExpirationDuration();
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  return (currentTime - loginTime!) > expirationDuration!;
}
