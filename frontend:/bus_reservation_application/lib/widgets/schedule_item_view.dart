import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';

class ScheduleItemView extends StatelessWidget {
  const ScheduleItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeNameSeatSelectionPage);
      },
      child: const Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text('hello'),
              subtitle: Text('hello'),
              trailing: Text('hello'),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('hello'),
                  Text('hello'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
