import 'package:bus_reservation_application/models/bus_model.dart';
import 'package:bus_reservation_application/models/but_route.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';

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

  void selectTime() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        timeOfDay = value;
      });
    });
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
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ticket Price',
                  hintText: 'Enter the ticket price',
                  hintStyle: const TextStyle(color: Colors.white),
                  errorStyle: const TextStyle(color: Colors.white),
                  filled: true,
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
                  filled: true,
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
                  filled: true,
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
                  Text(
                    timeOfDay == null
                        ? 'Time is not selected'
                        : timeOfDay.toString(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
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
