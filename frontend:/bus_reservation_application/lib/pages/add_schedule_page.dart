import 'package:bus_reservation_application/models/bus_model.dart';
import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/models/but_route.dart';
import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:bus_reservation_application/utils/helper_functions.dart';
import 'package:bus_reservation_application/widgets/login_alert_dialog.dart';
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
    if (selectedDateTime == null) {
      showMessage(context, 'Please select time');
      return;
    }
    if (formKey.currentState!.validate()) {
      final busSchedule = BusSchedule(
        bus: bus!,
        busRoute: busRoute!,
        departureTime: DateFormat('HH:mm').format(selectedDateTime!),
        ticketPrice: int.parse(priceController.text),
        discount: int.parse(discountController.text),
        processingFee: int.parse(processingFeeController.text),
      );
      Provider.of<AppDataProvider>(context, listen: false)
          .addSchedule(busSchedule)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMessage(context, response.message);
          resetFields();
        } else if (response.responseStatus == ResponseStatus.EXPIRED ||
            response.responseStatus == ResponseStatus.UNAUTHORIZED) {
          showLoginAlertDialog(
            context,
            message: response.message,
            callback: () {
              Navigator.pushNamed(context, routeNameLoginPage);
            },
          );
        }
      });
    }
  }

  Future<void> selectTime() async {
    final now = DateTime.now();
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? now),
    );

    if (selectedTime != null) {
      final selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      setState(() {
        this.selectedDateTime = selectedDateTime;
      });
    }
  }

  String get formattedTime {
    return selectedDateTime == null
        ? 'Time is not selected'
        : DateFormat('h:mm a').format(selectedDateTime!);
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
