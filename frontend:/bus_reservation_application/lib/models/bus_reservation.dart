import 'bus_schedule.dart';
import 'customer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_reservation.freezed.dart';
part 'bus_reservation.g.dart';

@JsonSerializable()
class BigIntConverter implements JsonConverter<BigInt, String> {
  const BigIntConverter();

  @override
  BigInt fromJson(String json) => BigInt.parse(json);

  @override
  String toJson(BigInt object) => object.toString();
}

@unfreezed
class BusReservation with _$BusReservation {
  factory BusReservation({
    int? reservationId,
    required Customer customer,
    required BusSchedule busSchedule,
    @BigIntConverter() required BigInt timestamp,
    required String departureDate,
    required int totalSeatBooked,
    required String seatNumbers,
    required String reservationStatus,
    required int totalPrice,
  }) = _BusReservation;

  factory BusReservation.fromJson(Map<String, dynamic> json) =>
      _$BusReservationFromJson(json);
}
