import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Displays a snackbar message at the bottom of the screen
/// [context] - BuildContext for showing the snackbar
/// [message] - Text to display in the snackbar
void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

/// Calculates the final total price including discount and fees
/// [discount] - Percentage discount to apply
/// [totalSeatBooked] - Number of seats reserved
/// [price] - Price per seat
/// [fee] - Additional booking fee
/// Returns the final total price as an integer
int getGrandTotal(int discount, int totalSeatBooked, int price, int fee) {
  final subTotal = (totalSeatBooked * price);
  final priceAfterDiscount = subTotal - ((subTotal * discount) / 100);
  return (priceAfterDiscount + fee).toInt();
}

/// Converts a time string in format "HH:mm" to a TimeOfDay object
/// [time] - Time string in "HH:mm" format
/// Returns TimeOfDay object representing the input time
TimeOfDay getTimeOfDay(String time) {
  final hour = int.parse(time.split(':')[0]);
  final minute = int.parse(time.split(':')[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

/// Saves the authentication token to shared preferences
/// [token] - JWT or authentication token to save
/// Returns true if save was successful
Future<bool> saveToken(String token) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.setString(accessToken, token);
}

/// Retrieves the stored authentication token
/// Returns the token string or null if not found
Future<String?> getToken() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(accessToken);
}

/// Saves the login timestamp to shared preferences
/// [time] - Login time in milliseconds since epoch
/// Returns true if save was successful
Future<bool> saveLoginTime(int time) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.setInt(loginTime, time);
}

/// Retrieves the stored login timestamp
/// Returns the timestamp in milliseconds or null if not found
Future<int?> getLoginTime() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getInt(loginTime);
}

/// Saves the token expiration duration to shared preferences
/// [duration] - Duration in milliseconds until token expires
/// Returns true if save was successful
Future<bool> saveExpirationDuration(int duration) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.setInt(expirationDuration, duration);
}

/// Retrieves the stored token expiration duration
/// Returns the duration in milliseconds or null if not found
Future<int?> getExpirationDuration() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getInt(expirationDuration);
}

/// Checks if the current authentication token has expired
/// Returns true if token has expired, false otherwise
/// Note: Assumes both loginTime and expirationDuration are non-null
Future<bool> hasTokenExpired() async {
  final loginTime = await getLoginTime();
  final expirationDuration = await getExpirationDuration();
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  return (currentTime - loginTime!) > expirationDuration!;
}
