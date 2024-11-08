import 'package:flutter/material.dart';
import '../models/reservation_expansion_item.dart';

class ReservationItemHeaderView extends StatelessWidget {
  const ReservationItemHeaderView({super.key, required this.header});

  final ReservationExpansionHeader header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('${header.date} ${header.busSchedule?.departureTime}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${header.busSchedule?.busRoute.routeName} - ${header.busSchedule?.bus.busName}'),
            Text(
                'Booking Time: ${DateTime.fromMillisecondsSinceEpoch(header.timestamp).toString()}'),
          ],
        ),
      ),
    );
  }
}
