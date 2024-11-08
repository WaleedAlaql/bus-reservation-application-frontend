import 'package:bus_reservation_application/models/bus_model.dart';
import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/models/but_route.dart';
import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:bus_reservation_application/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final processingFeeController = TextEditingController();
  String? busType;
  Bus? bus;
  BusRoute? busRoute;
  DateTime? selectedDateTime;

  @override
  void didChangeDependencies() {
    getData();
    super.didChangeDependencies();
  }

  Future<void> getData() async {
    await Provider.of<AppDataProvider>(context, listen: false).getAllBus();
    await Provider.of<AppDataProvider>(context, listen: false).getAllRoute();
  }

  void addSchedule() async {
    // Check if a bus is selected
    if (bus == null) {
      showMessage(context, 'Please select a bus');
      return;
    }
    // Check if a route is selected
    if (busRoute == null) {
      showMessage(context, 'Please select a route');
      return;
    }
    // Check if a departure time is selected
    if (selectedDateTime == null) {
      showMessage(context, 'Please select time');
      return;
    }
    // Validate the form fields
    if (formKey.currentState!.validate()) {
      try {
        // Create a new BusSchedule object with the provided details
        final busSchedule = BusSchedule(
          bus: bus!,
          busRoute: busRoute!,
          departureTime: DateFormat('HH:mm').format(selectedDateTime!),
          ticketPrice: int.parse(priceController.text),
          discount: int.parse(
              discountController.text.isEmpty ? "0" : discountController.text),
          processingFee: int.parse(processingFeeController.text.isEmpty
              ? "15"
              : processingFeeController.text),
        );

        // Attempt to add the schedule using the AppDataProvider
        final response =
            await Provider.of<AppDataProvider>(context, listen: false)
                .addSchedule(busSchedule);

        // Check the response status
        if (response.responseStatus == ResponseStatus.SAVED) {
          // Show success message and reset fields if saved
          showMessage(context, response.message);
          resetFields();
        } else {
          // Handle failure and show appropriate error message
          String errorMessage = response.message;
          if (errorMessage.contains('Duplicate entry')) {
            errorMessage =
                'A schedule already exists for this bus, route and time combination';
          }
          showMessage(context, 'Failed to add schedule: $errorMessage');
        }
      } catch (error) {
        // Handle exceptions and show error message
        String errorMessage = error.toString();
        if (errorMessage.contains('Duplicate entry')) {
          errorMessage =
              'A schedule already exists for this bus, route and time combination';
        }
        showMessage(context, 'Error adding schedule: $errorMessage');
      }
    }
  }

  Future<void> selectTime() async {
    // Get the current date and time
    final now = DateTime.now();

    // Show a time picker dialog to the user, with the initial time set to the previously selected time or the current time
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? now),
    );

    // If the user selects a time, update the selectedDateTime with the chosen time
    if (selectedTime != null) {
      // Create a new DateTime object with the current date and the selected time
      final selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      // Update the state with the new selectedDateTime
      setState(() {
        this.selectedDateTime = selectedDateTime;
      });
    }
  }

  // This getter returns a formatted string representation of the selected time.
  // If no time is selected, it returns a default message indicating that.
  String get formattedTime {
    return selectedDateTime == null
        ? 'Time is not selected' // Message shown when no time is selected
        : DateFormat('h:mm a').format(
            selectedDateTime!); // Formats the selected time as 'hour:minute AM/PM'
  }

  void resetFields() {
    priceController.clear();
    discountController.clear();
    processingFeeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Schedule')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Consumer<AppDataProvider>(
              builder: (context, provider, child) => DropdownButtonFormField(
                items: provider.busList
                    .map((e) => DropdownMenuItem<Bus>(
                          value: e,
                          child: Text('${e.busName} - ${e.busType}'),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => bus = value),
                value: bus,
                hint: const Text('Select Bus'),
              ),
            ),
            const SizedBox(height: 10),
            Consumer<AppDataProvider>(
              builder: (context, provider, child) => DropdownButtonFormField(
                items: provider.routeList
                    .map((e) => DropdownMenuItem<BusRoute>(
                          value: e,
                          child: Text(e.routeName),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => busRoute = value),
                value: busRoute,
                hint: const Text('Select Route'),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Ticket Price'),
              validator: (value) =>
                  value?.isEmpty ?? true ? emptyFieldErrMessage : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: discountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Discount (in %)'),
              validator: (value) =>
                  value?.isEmpty ?? true ? emptyFieldErrMessage : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: processingFeeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Processing Fee'),
              validator: (value) =>
                  value?.isEmpty ?? true ? emptyFieldErrMessage : null,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: selectTime,
                  child: const Text('Select Time'),
                ),
                Text(formattedTime),
              ],
            ),
            ElevatedButton(
              onPressed: addSchedule,
              child: const Text('Add Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}
