import 'package:bus_reservation_application/models/but_route.dart';
import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:bus_reservation_application/utils/helper_functions.dart';
import 'package:bus_reservation_application/widgets/login_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void resetFields() {
    distanceController.clear();
  }

  void addRoute() {
    // Check if the form is valid
    if (formKey.currentState!.validate()) {
      // Create a new BusRoute object with the provided details
      final route = BusRoute(
        routeName: '$from - $to', // Set the route name as "from - to"
        cityFrom: from!, // Set the starting city
        cityTo: to!, // Set the destination city
        distanceInKm:
            double.parse(distanceController.text), // Parse and set the distance
      );

      // Add the route using the AppDataProvider
      Provider.of<AppDataProvider>(context, listen: false)
          .addRoute(route)
          .then((response) {
        // Check the response status
        if (response.responseStatus == ResponseStatus.SAVED) {
          // If saved successfully, show a message and reset fields
          showMessage(context, response.message);
          resetFields();
        } else if (response.responseStatus == ResponseStatus.EXPIRED ||
            response.responseStatus == ResponseStatus.UNAUTHORIZED) {
          // If the session is expired or unauthorized, show a login alert dialog
          showLoginAlertDialog(
            context,
            message: response.message,
            callback: () {
              // Navigate to the login page on callback
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
                  onPressed: addRoute,
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
