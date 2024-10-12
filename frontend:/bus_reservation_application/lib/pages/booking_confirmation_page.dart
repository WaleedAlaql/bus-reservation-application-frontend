import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/bus_schedule.dart';

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
  void initState() {
    super.initState();
    nameController.text = 'waleed';
    phoneNumberController.text = '03001234567';
    emailController.text = 'waleed@gmail.com';
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (isFirstTime) {
  //     final args = ModalRoute.of(context)?.settings.arguments as List;
  //     date = args[0];
  //     busSchedule = args[1];
  //     seatNumbers = args[2];
  //     totalSeatsBooked = args[3];
  //     isFirstTime = false;
  //   }
  // }

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
                    const Text(
                      'Route:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Date:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Ticket Price:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Total Seats:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Seat Numbers:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Divider(thickness: 2),
                    const Text(
                      'Grand Total:',
                      style: TextStyle(
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
    // if (formKey.currentState!.validate()) {
    //   // Handle valid form
    //   final customer = Customer(
    //     customerName: nameController.text,
    //     mobile: phoneNumberController.text,
    //     email: emailController.text,
    //   );
    //   final reservation = BusReservation(
    //     customer: customer,
    //     busSchedule: busSchedule,
    //     timestamp: DateTime.now().millisecondsSinceEpoch,
    //     departureDate: date,
    //     totalSeatBooked: totalSeatsBooked,
    //     seatNumbers: seatNumbers,
    //     reservationStatus: reservationActive,
    //     totalPrice: getGrandTotal(
    //       busSchedule.discount,
    //       totalSeatsBooked,
    //       busSchedule.ticketPrice,
    //       busSchedule.fee,
    //     ),
    //   );
    //   Provider.of<AppDataProvider>(context, listen: false)
    //       .addReservation(reservation)
    //       .then((response) {
    //     if (response.responseStatus == ResponseStatus.SAVED) {
    Navigator.popUntil(context, ModalRoute.withName(routeNameHome));
    //     } else {
    //       showMessage(context, response.message);
    //     }
    //   }).catchError((error) {
    //     showMessage(context, error.toString());
    //   });
    // } else {
    //   // Handle invalid form
    // }
  }
}
