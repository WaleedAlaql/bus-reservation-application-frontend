import 'bus_schedule.dart';
import 'customer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_reservation.freezed.dart';
part 'bus_reservation.g.dart';

@JsonSerializable()
// A custom converter to handle JSON serialization and deserialization for BigInt types.
class BigIntConverter implements JsonConverter<BigInt, dynamic> {
  const BigIntConverter();

  @override
  // Converts a JSON value to BigInt. Supports both String and num types.
  BigInt fromJson(dynamic json) {
    if (json is String) {
      return BigInt.parse(json);
    } else if (json is num) {
      return BigInt.from(json);
    }
    throw const FormatException('Invalid timestamp format');
  }

  @override
  // Converts a BigInt to a String for JSON serialization.
  String toJson(BigInt object) => object.toString();
}

@unfreezed
// A data class representing a bus reservation, using the freezed package for immutability and union types.
class BusReservation with _$BusReservation {
  // Factory constructor for creating a BusReservation instance.
  factory BusReservation({
    int? reservationId, // Optional reservation ID.
    required Customer customer, // The customer making the reservation.
    required BusSchedule
        busSchedule, // The bus schedule associated with the reservation.
    @BigIntConverter()
    required BigInt
        timestamp, // The timestamp of the reservation, using BigIntConverter.
    required String departureDate, // The departure date of the bus.
    required int totalSeatBooked, // Total number of seats booked.
    required String seatNumbers, // The seat numbers booked.
    required String reservationStatus, // The status of the reservation.
    required int totalPrice, // The total price of the reservation.
  }) = _BusReservation;

  // Factory constructor for creating a BusReservation instance from a JSON map.
  factory BusReservation.fromJson(Map<String, dynamic> json) =>
      _$BusReservationFromJson(json);
}
