import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/utils/colors.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:bus_reservation_application/widgets/seat_plan_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as List;

    busSchedule = args[0];
    date = args[1];
    getData();
  }

  getData() async {
    final reservations =
        await Provider.of<AppDataProvider>(context, listen: false)
            .getReservationsByScheduleAndDepartureDate(
                busSchedule.scheduleId!, date);
    setState(() {
      isDataLoading = false;
    });
    List<String> seats = [];
    for (final reservation in reservations) {
      totalSeatBooked += reservation.totalSeatBooked;
      seats.add(reservation.seatNumbers);
    }
    bookedSeatNumbers = seats.join(', ');
  }

  void onSeatSelected(bool isSelected, String seatNumber) {
    setState(() {
      if (isSelected) {
        selectedSeats.add(seatNumber);
      } else {
        selectedSeats.remove(seatNumber);
      }
      selectedSeatStringNotifier.value = selectedSeats.join(', ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Selection'),
      ),
      body: SafeArea(
        child: Center(
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
                        const Text(
                          'Booked',
                          style: TextStyle(fontSize: 12),
                        ),
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
              // if (!isDataLoading)
              Expanded(
                child: SingleChildScrollView(
                  child: SeatPlanView(
                    totalSeats: busSchedule.bus.totalSeat,
                    bookedSeatNumbers: bookedSeatNumbers,
                    totalSeatBooked: totalSeatBooked,
                    isBusinessClass:
                        busSchedule.bus.busType == busTypeACBusiness,
                    onSeatSelected: (value, seatNumber) {
                      if (value) {
                        selectedSeats.add(seatNumber);
                      } else {
                        selectedSeats.remove(seatNumber);
                      }
                      selectedSeatStringNotifier.value =
                          selectedSeats.join(', ');
                    },
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  if (selectedSeats.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select at least one seat'),
                      ),
                    );
                    return;
                  }
                  Navigator.pushNamed(context, routeNameBookingConfirmationPage,
                      arguments: [
                        busSchedule,
                        date,
                        selectedSeatStringNotifier.value,
                        selectedSeats.length,
                      ]);
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
