import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';

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
                          DropdownMenuItem<String>(child: Text(e), value: e))
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
                  filled: true,
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
                  filled: true,
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
                  filled: true,
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        resetFields();
                      }
                    },
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
