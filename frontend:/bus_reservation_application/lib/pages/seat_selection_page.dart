import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/utils/colors.dart';
import 'package:flutter/material.dart';

class SeatSelectionPage extends StatefulWidget {
  const SeatSelectionPage({super.key});

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  late BusSchedule busSchedule;
  late String date;
  int totalSeatBooked = 0;
  String bookedSeatNumbers = '';
  List<String> selectedSeats = [];
  bool isFirstTime = true;
  bool isDataLoading = true;
  ValueNotifier<String> selectedSeatStringNotifier = ValueNotifier('');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Selection'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: seatBookedColor,
                      ),
                      const SizedBox(width: 10),
                      const Text('Booked'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: seatAvailableColor,
                      ),
                      const SizedBox(width: 10),
                      const Text('Available'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: selectedSeatStringNotifier,
              builder: (context, value, child) {
                return Text(
                  'Selected Seats: $value',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
