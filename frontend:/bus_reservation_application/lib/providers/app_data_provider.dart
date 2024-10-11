import 'package:bus_reservation_application/datasource/data_source.dart';
import 'package:bus_reservation_application/datasource/dummy_data_source.dart';
import 'package:bus_reservation_application/models/bus_reservation.dart';
import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/models/but_route.dart';
import 'package:flutter/material.dart';

class AppDataProvider extends ChangeNotifier {
  final DataSource _dataSource = DummyDataSource();
  List<BusSchedule> _schedules = [];
  List<BusSchedule> get schedules => _schedules;

  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) async {
    return await _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }

  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    _schedules = await _dataSource.getSchedulesByRouteName(routeName);
    notifyListeners();
    return _schedules;
  }

  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    return await _dataSource.getReservationsByScheduleAndDepartureDate(
        scheduleId, departureDate);
  }
}
