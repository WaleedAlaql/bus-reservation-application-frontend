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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      final args = ModalRoute.of(context)?.settings.arguments as List;
      date = args[0];
      busSchedule = args[1];
      seatNumbers = args[2];
      totalSeatsBooked = args[3];
      isFirstTime = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
    );
  }
}
