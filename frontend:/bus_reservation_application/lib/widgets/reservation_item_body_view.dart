import 'package:flutter/material.dart';
import '../models/reservation_expansion_item.dart';

class ReservationItemBodyView extends StatelessWidget {
  const ReservationItemBodyView({super.key, required this.body});

  final ReservationExpansionBody body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Customer Name: ${body.customer.customerName}'),
          Text('Customer Phone Number: ${body.customer.mobile}'),
          Text('Customer Email: ${body.customer.email}'),
          Text('Total Seat Booked: ${body.totalSeatedBooked}'),
          Text('Seat Numbers: ${body.seatNumbers}'),
          Text('Total Price: ${body.totalPrice}'),
        ],
      ),
    );
  }
}
