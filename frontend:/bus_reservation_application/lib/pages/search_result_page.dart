import 'package:bus_reservation_application/models/but_route.dart';
import 'package:bus_reservation_application/widgets/schedule_item_view.dart';
import 'package:flutter/material.dart';

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
        children: const [
          Text('hello'),
          ScheduleItemView(),
          ScheduleItemView(),
          ScheduleItemView(),
        ],
      ),
    );
  }
}
