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

    // Extract arguments passed during navigation
    // args[0] contains BusSchedule object
    // args[1] contains selected date string
    final args = ModalRoute.of(context)!.settings.arguments as List;
    busSchedule = args[0];
    date = args[1];

    // Fetch reservation data for the selected schedule and date
    getData();
  }

  /// Fetches and processes reservation data for the selected bus schedule and date
  getData() async {
    // Retrieve all reservations for this schedule and date from the provider
    final reservations =
        await Provider.of<AppDataProvider>(context, listen: false)
            .getReservationsByScheduleAndDepartureDate(
                busSchedule.scheduleId!, date);

    // Update loading state once data is retrieved
    setState(() {
      isDataLoading = false;
    });

    // Process the reservations to get total seats and seat numbers
    List<String> seats = [];
    for (final reservation in reservations) {
      // Accumulate total number of booked seats
      totalSeatBooked += reservation.totalSeatBooked;
      // Collect all seat numbers from each reservation
      seats.add(reservation.seatNumbers);
    }

    // Combine all seat numbers into a single comma-separated string
    bookedSeatNumbers = seats.join(', ');
  }

  /// Handles the selection and deselection of seats
  ///
  /// [isSelected] - boolean indicating if the seat is being selected (true) or deselected (false)
  /// [seatNumber] - string representing the seat number (e.g., "A1", "B2")
  void onSeatSelected(bool isSelected, String seatNumber) {
    setState(() {
      if (isSelected) {
        // Add the seat number to the list when selected
        selectedSeats.add(seatNumber);
      } else {
        // Remove the seat number from the list when deselected
        selectedSeats.remove(seatNumber);
      }
      // Update the ValueNotifier with a comma-separated string of selected seats
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
              // ValueListenableBuilder widget that rebuilds when selectedSeatStringNotifier changes
              // This provides real-time updates of selected seats without rebuilding the entire widget tree
              ValueListenableBuilder(
                // Listen to changes in the selectedSeatStringNotifier
                valueListenable: selectedSeatStringNotifier,
                // Builder function that returns the widget to display
                // context: Build context
                // value: Current value of the ValueNotifier (selected seats string)
                // child: Optimization parameter for static child widgets (unused here)
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
                  // Navigate to the booking confirmation page with required booking details
                  Navigator.pushNamed(context, routeNameBookingConfirmationPage,
                      arguments: [
                        busSchedule, // The selected bus schedule object containing route and bus details
                        date, // Selected journey date
                        selectedSeatStringNotifier
                            .value, // Comma-separated string of selected seat numbers (e.g., "A1, B2")
                        selectedSeats.length, // Total number of seats selected
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
