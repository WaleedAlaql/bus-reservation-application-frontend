import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@unfreezed
class Customer with _$Customer {
  // Factory constructor for creating a new Customer instance
  factory Customer({
    int? customerId, // Optional customer ID
    required String customerName, // Required customer name
    required String mobile, // Required mobile number
    required String email, // Required email address
  }) = _Customer;

  // Factory constructor for creating a Customer instance from a JSON map
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
