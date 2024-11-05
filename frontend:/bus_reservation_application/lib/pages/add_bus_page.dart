import 'package:bus_reservation_application/models/bus_model.dart';
import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:bus_reservation_application/utils/helper_functions.dart';
import 'package:bus_reservation_application/widgets/login_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBusPage extends StatefulWidget {
  const AddBusPage({super.key});

  @override
  State<AddBusPage> createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
  final formKey = GlobalKey<FormState>();
  final busNameController = TextEditingController();
  final busNumberController = TextEditingController();
  final busSeatController = TextEditingController();
  String? busType;

  @override
  void dispose() {
    busNameController.dispose();
    busNumberController.dispose();
    busSeatController.dispose();
    super.dispose();
  }

  void resetFields() {
    busNameController.clear();
    busNumberController.clear();
    busSeatController.clear();
    busType = null;
  }

  void addBus() {
    if (formKey.currentState!.validate()) {
      final bus = Bus(
        busName: busNameController.text,
        busNumber: busNumberController.text,
        busType: busType!,
        totalSeat: int.parse(busSeatController.text),
      );
      Provider.of<AppDataProvider>(context, listen: false)
          .addBus(bus)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bus'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              DropdownButtonFormField<String>(
                  value: busType,
                  isExpanded: true,
                  hint: const Text('Select Bus Type'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  items: busTypes
                      .map((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      busType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a bus type';
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
              TextFormField(
                controller: busNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter bus name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_bus),
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
                controller: busNumberController,
                decoration: const InputDecoration(
                  hintText: 'Enter bus number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
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
                controller: busSeatController,
                decoration: const InputDecoration(
                  hintText: 'Enter bus seat',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.chair_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: addBus,
                    child: const Text('Add Bus'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
