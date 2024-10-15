import 'package:flutter/material.dart';

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
