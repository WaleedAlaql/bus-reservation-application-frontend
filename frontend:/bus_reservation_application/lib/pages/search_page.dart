import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:bus_reservation_application/utils/helper_functions.dart';
import 'package:bus_reservation_application/widgets/main_drawer.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final formKey = GlobalKey<FormState>();
  String? fromCity;
  String? toCity;
  DateTime? selectedDate;

  void selectDate() {
    // Show a date picker dialog to the user
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date to today
      firstDate: DateTime.now(), // Set the earliest selectable date to today
      lastDate: DateTime.now().add(const Duration(
          days: 365)), // Set the latest selectable date to one year from today
    ).then((value) {
      // Once a date is selected, update the state with the selected date
      setState(() {
        selectedDate = value;
      });
    });
  }

  void search() {
    // Check if a date has been selected
    if (selectedDate == null) {
      // Show an error message if no date is selected
      showMessage(context, selectDateErrMessage);
      return;
    }
    // Validate the form fields
    if (formKey.currentState!.validate()) {
      // Fetch the route based on the selected cities
      Provider.of<AppDataProvider>(context, listen: false)
          .getRouteByCityFromAndCityTo(fromCity!, toCity!)
          .then((route) {
        // If a route is found, navigate to the search result page
        if (route != null) {
          Navigator.pushNamed(context, routeNameSearchResultPage, arguments: [
            route,
            // Pass the formatted selected date as an argument
            formatDate(selectedDate!, ['dd', '-', 'MM', '-', 'yyyy'])
          ]);
        } else {
          // Show an error message if no route is found
          showMessage(context, 'No route found');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: const MainDrawer(),
        body: Form(
          key: formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: [
                DropdownButtonFormField<String>(
                  value: fromCity,
                  isExpanded: true,
                  hint: const Text('Select City'),
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white),
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
                  items: cities
                      .map((city) => DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      fromCity = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: toCity,
                  isExpanded: true,
                  hint: const Text('Select City'),
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white),
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
                  items: cities
                      .map((city) => DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      toCity = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: selectDate,
                      child: const Text('Select Date'),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      selectedDate == null
                          ? 'Date is not selected'
                          : formatDate(
                              selectedDate!, ['dd', '-', 'MM', '-', 'yyyy']),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: search,
                    child: const Text('Search'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
