import 'package:bus_reservation_application/models/bus_reservation.dart';
import 'package:bus_reservation_application/models/customer.dart';
import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:bus_reservation_application/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/bus_schedule.dart';
import 'dart:math' as math;

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage({super.key});

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  late BusSchedule busSchedule;
  late String date;
  late int totalSeatsBooked;
  late String seatNumbers;
  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      final args = ModalRoute.of(context)!.settings.arguments as List;
      busSchedule = args[0];
      date = args[1];
      seatNumbers = args[2];
      totalSeatsBooked = args[3];
      isFirstTime = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please fill the following details',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    nameController.text = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  filled: true,
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    phoneNumberController.text = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    emailController.text = value;
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Booking Details',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Name: ${nameController.text}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Phone Number: ${phoneNumberController.text}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Email: ${emailController.text}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Route: ${busSchedule.busRoute.routeName}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Departure Date: $date',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Departure Time: ${busSchedule.departureTime}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Ticket Price: ${busSchedule.ticketPrice}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Total Seats: $totalSeatsBooked',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Seat Numbers: $seatNumbers',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Discount: ${busSchedule.discount}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Processing Fee: ${busSchedule.processingFee}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(thickness: 2),
                    Text(
                      'Grand Total: ${getGrandTotal(busSchedule.discount, totalSeatsBooked, busSchedule.ticketPrice, busSchedule.processingFee)}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: confirmBooking,
                child: const Text('Confirm Booking')),
          ],
        ),
      ),
    );
  }

  void confirmBooking() {
    if (formKey.currentState!.validate()) {
      final customer = Customer(
        customerName: nameController.text,
        mobile: phoneNumberController.text,
        email: emailController.text,
      );

      final reservation = BusReservation(
        customer: customer,
        busSchedule: busSchedule,
        timestamp: BigInt.from(DateTime.now().millisecondsSinceEpoch ~/ 1000 +
            busSchedule.scheduleId! * 1000000 +
            math.Random().nextInt(999)),
        departureDate: date,
        totalSeatBooked: totalSeatsBooked,
        seatNumbers: seatNumbers,
        reservationStatus: reservationActive,
        totalPrice: getGrandTotal(
          busSchedule.discount,
          totalSeatsBooked,
          busSchedule.ticketPrice,
          busSchedule.processingFee,
        ),
      );
      Provider.of<AppDataProvider>(context, listen: false)
          .addReservation(reservation)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMessage(context, response.message);
          Navigator.popUntil(context, ModalRoute.withName(routeNameHome));
        } else {
          showMessage(
              context, 'Failed to save reservation: ${response.message}');
          print(response.message);
        }
      }).catchError((error) {
        showMessage(context, 'JSON Parse Error: $error');
      });
    }
  }
}
