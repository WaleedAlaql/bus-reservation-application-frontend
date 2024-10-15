import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';

class AddRoutePage extends StatefulWidget {
  const AddRoutePage({super.key});

  @override
  State<AddRoutePage> createState() => _AddRoutePageState();
}

class _AddRoutePageState extends State<AddRoutePage> {
  final formKey = GlobalKey<FormState>();
  String? from;
  String? to;
  final distanceController = TextEditingController();

  @override
  void dispose() {
    distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Route'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              value: from,
              isExpanded: true,
              hint: const Text('From'),
              decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white),
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: cities.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  from = value;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: to,
              isExpanded: true,
              hint: const Text('To'),
              decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white),
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: cities.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  to = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: distanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Distance (in km)',
                hintStyle: const TextStyle(color: Colors.white),
                errorStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.social_distance),
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
            Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    }
                  },
                  child: const Text('Add Route'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
