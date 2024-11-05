import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';

class ScheduleItemView extends StatelessWidget {
  const ScheduleItemView(
      {super.key, required this.date, required this.schedule});

  final String date;
  final BusSchedule schedule;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeNameSeatSelectionPage,
            arguments: [schedule, date]);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text(schedule.bus.busName),
              subtitle: Text(schedule.bus.busType),
              trailing: Text('$currency ${schedule.ticketPrice}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('From: ${schedule.busRoute.cityFrom}',
                      style: const TextStyle(fontSize: 17)),
                  Text('To: ${schedule.busRoute.cityTo}',
                      style: const TextStyle(fontSize: 17)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Departure Date: ${schedule.departureTime}',
                      style: const TextStyle(fontSize: 17)),
                  Text('Total Seats: ${schedule.bus.totalSeat}',
                      style: const TextStyle(fontSize: 17)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
