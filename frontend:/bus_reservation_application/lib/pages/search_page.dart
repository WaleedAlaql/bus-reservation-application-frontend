import 'package:bus_reservation_application/utils/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity;
  String? toCity;
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list, size: 30, color: Colors.white),
          ),
          title: const Text('Search'),
        ),
        body: Form(
          child: Center(
            child: ListView(
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
                )
              ],
            ),
          ),
        ));
  }

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((value) {
      setState(() {
        selectedDate = value;
      });
    });
  }
}
