import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/models/customer.dart';

class ReservationExpansionItem {
  bool isExpanded;
  ReservationExpansionHeader header;
  ReservationExpansionBody body;

  ReservationExpansionItem({
    this.isExpanded = false,
    required this.header,
    required this.body,
  });
}

class ReservationExpansionHeader {
  int? reservationId;
  String date;
  BusSchedule? busSchedule;
  int timestamp;
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
  Customer customer;
  int totalSeatedBooked;
  String seatNumbers;
  int totalPrice;

  ReservationExpansionBody({
    required this.customer,
    required this.totalSeatedBooked,
    required this.seatNumbers,
    required this.totalPrice,
  });
}
