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
          Consumer<AppDataProvider>(
            builder: (context, appDataProvider, child) =>
                FutureBuilder<List<BusSchedule>>(
              future: appDataProvider.getSchedulesByRouteName(route.routeName),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final schedules = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: schedules
                        .map((schedule) => ScheduleItemView(
                              schedule: schedule,
                              date: date,
                            ))
                        .toList(),
                  );
                }
                if (snapshot.hasError) {
                  return const Text('Failed to fetch data');
                }
                return const Text('Please wait...');
              },
            ),
          ),
        ],
      ),
    );
  }
}
