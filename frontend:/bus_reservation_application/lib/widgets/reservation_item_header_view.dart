import 'package:flutter/material.dart';
import '../models/reservation_expansion_item.dart';

class ReservationItemHeaderView extends StatelessWidget {
  const ReservationItemHeaderView({super.key, required this.header});

  final ReservationExpansionItem header;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          '${header.header.date} ${header.header.busSchedule?.departureTime}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${header.header.busSchedule?.busRoute.routeName}'),
          Text(
              'Booking Time: ${DateTime.fromMillisecondsSinceEpoch(header.header.timestamp).toString()}'),
        ],
      ),
    );
  }
}
