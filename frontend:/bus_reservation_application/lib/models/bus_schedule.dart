import 'bus_model.dart';
import 'but_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_schedule.freezed.dart';
part 'bus_schedule.g.dart';

@unfreezed
class BusSchedule with _$BusSchedule {
  // Factory constructor for creating a new BusSchedule instance
  factory BusSchedule({
    int? scheduleId, // Optional schedule ID
    required Bus bus, // The bus associated with this schedule
    required BusRoute busRoute, // The route the bus will take
    required String departureTime, // The departure time for the bus
    required int ticketPrice, // The price of a ticket for this schedule
    @Default(0) int discount, // Discount on the ticket price, default is 0
    @Default(15)
    int processingFee, // Processing fee for the ticket, default is 15
  }) = _BusSchedule;

  // Factory constructor for creating a BusSchedule instance from a JSON map
  factory BusSchedule.fromJson(Map<String, dynamic> json) =>
      _$BusScheduleFromJson(json);
}
