import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/models/customer.dart';

class ReservationExpansionItem {
  // Indicates whether the reservation item is expanded in the UI
  bool isExpanded;
  // Header information for the reservation
  ReservationExpansionHeader header;
  // Body details for the reservation
  ReservationExpansionBody body;

  ReservationExpansionItem({
    this.isExpanded = false, // Default to not expanded
    required this.header,
    required this.body,
  });
}

class ReservationExpansionHeader {
  // Unique identifier for the reservation
  int? reservationId;
  // Date of the reservation
  String date;
  // Schedule information for the bus
  BusSchedule? busSchedule;
  // Timestamp of the reservation creation or update
  int timestamp;
  // Current status of the reservation (e.g., confirmed, pending)
  String reservationStatus;

  ReservationExpansionHeader({
    required this.reservationId,
    required this.date,
    required this.busSchedule,
    required this.timestamp,
    required this.reservationStatus,
  });
}

class ReservationExpansionBody {
  // Customer details associated with the reservation
  Customer customer;
  // Total number of seats booked
  int totalSeatedBooked;
  // Seat numbers assigned to the reservation
  String seatNumbers;
  // Total price for the reservation
  int totalPrice;

  ReservationExpansionBody({
    required this.customer,
    required this.totalSeatedBooked,
    required this.seatNumbers,
    required this.totalPrice,
  });
}
