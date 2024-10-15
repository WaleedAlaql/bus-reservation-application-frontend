import 'package:bus_reservation_application/models/bus_model.dart';
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
  TimeOfDay? timeOfDay;
  DateTime? selectedDateTime;

  Future<void> selectTime() async {
    try {
      final now = DateTime.now();
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? now),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: child!,
          );
        },
      );

      if (selectedTime != null) {
        final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        if (selectedDateTime.isBefore(now)) {
          showMessage(context, 'Please select a future time.');
          return;
        }

        setState(() {
          this.selectedDateTime = selectedDateTime;
        });
      }
    } catch (e) {
      showMessage(context, 'Error selecting time: $e');
    }
  }

  String get formattedTime {
    return selectedDateTime == null
        ? 'Time is not selected'
        : DateFormat('h:mm a').format(selectedDateTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Schedule'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Consumer<AppDataProvider>(
                builder: (context, provider, child) => DropdownButtonFormField(
                  items: provider.busList
                      .map(
                        (e) => DropdownMenuItem<Bus>(
                          value: e,
                          child: Text('${e.busName} - ${e.busType}'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      bus = value;
                    });
                  },
                  isExpanded: true,
                  value: bus,
                  hint: const Text('Select Bus'),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white),
                    errorStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.directions_bus),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Consumer<AppDataProvider>(
                builder: (context, provider, child) => DropdownButtonFormField(
                  items: provider.routeList
                      .map(
                        (e) => DropdownMenuItem<BusRoute>(
                          value: e,
                          child: Text(e.routeName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      busRoute = value;
                    });
                  },
                  isExpanded: true,
                  value: busRoute,
                  hint: const Text('Select Route'),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white),
                    errorStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.route),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ticket Price',
                  hintText: 'Enter the ticket price',
                  hintStyle: const TextStyle(color: Colors.white),
                  errorStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: discountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Discount (in %)',
                  hintText: 'Enter the discount',
                  hintStyle: const TextStyle(color: Colors.white),
                  errorStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.percent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: processingFeeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Processing Fee',
                  hintText: 'Enter the processing fee',
                  hintStyle: const TextStyle(color: Colors.white),
                  errorStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.payments),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: selectTime,
                    child: const Text('Select Time'),
                  ),
                  const SizedBox(width: 10),
                  Text(formattedTime),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (timeOfDay == null) {
                      showMessage(context, 'Please select time');
                      return;
                    }
                  },
                  child: const Text('Add Schedule'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
