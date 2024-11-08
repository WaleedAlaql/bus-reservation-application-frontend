import 'package:freezed_annotation/freezed_annotation.dart';
part 'bus_model.freezed.dart';
part 'bus_model.g.dart';

@unfreezed
class Bus with _$Bus {
  // Factory constructor for creating a new Bus instance
  factory Bus({
    int? busId, // Optional bus ID
    required String busName, // Name of the bus
    required String busNumber, // Number assigned to the bus
    required String busType, // Type of the bus (e.g., city, intercity)
    required int totalSeat, // Total number of seats in the bus
  }) = _Bus;

  // Factory constructor for creating a Bus instance from a JSON map
  factory Bus.fromJson(Map<String, dynamic> json) => _$BusFromJson(json);
}
