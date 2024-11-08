import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/models/but_route.dart';
import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/widgets/schedule_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    final BusRoute route = argList[0];
    final String date = argList[1];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Text(
            'Showing results for ${route.cityFrom} to ${route.cityTo} on $date',
            style: const TextStyle(fontSize: 20),
          ),
          // Consumer listens to changes in AppDataProvider
          // and rebuilds when the provider data changes
          Consumer<AppDataProvider>(
            builder: (context, appDataProvider, child) =>
                // FutureBuilder handles the async state management
                // for fetching bus schedules
                FutureBuilder<List<BusSchedule>>(
              // Async call to get schedules for the selected route
              future: appDataProvider.getSchedulesByRouteName(route.routeName),
              builder: (context, snapshot) {
                // When data is successfully loaded
                if (snapshot.hasData) {
                  final schedules = snapshot.data!;
                  // Display schedules in a vertical column
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: schedules
                        // Convert each schedule into a ScheduleItemView widget
                        .map((schedule) => ScheduleItemView(
                              schedule: schedule,
                              date: date,
                            ))
                        .toList(),
                  );
                }
                // Handle error state
                if (snapshot.hasError) {
                  return const Text('Failed to fetch data');
                }
                // Show loading state while waiting for data
                return const Text('Please wait...');
              },
            ),
          ),
        ],
      ),
    );
  }
}
