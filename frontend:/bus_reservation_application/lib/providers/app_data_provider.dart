import 'package:bus_reservation_application/datasource/app_data_source.dart';
import 'package:bus_reservation_application/datasource/data_source.dart';
import 'package:bus_reservation_application/models/app_user.dart';
import 'package:bus_reservation_application/models/auth_response_model.dart';
import 'package:bus_reservation_application/models/bus_model.dart';
import 'package:bus_reservation_application/models/bus_reservation.dart';
import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/models/but_route.dart';
import 'package:bus_reservation_application/models/reservation_expansion_item.dart';
import 'package:bus_reservation_application/models/response_model.dart';
import 'package:bus_reservation_application/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class AppDataProvider extends ChangeNotifier {
  List<Bus> _busList = [];
  List<BusRoute> _routeList = [];
  List<BusReservation> _reservationList = [];
  List<BusSchedule> _scheduleList = [];

  List<Bus> get busList => _busList;
  List<BusRoute> get routeList => _routeList;
  List<BusReservation> get reservationList => _reservationList;
  List<BusSchedule> get scheduleList => _scheduleList;
  final DataSource _dataSource = AppDataSource();

  Future<AuthResponseModel?> login(AppUser user) async {
    final authResponse = await _dataSource.login(user);
    if (authResponse == null) return null;
    await saveToken(authResponse.accessToken ?? '');
    await saveLoginTime(authResponse.loginTime ?? 0);
    await saveExpirationDuration(authResponse.expirationDuration ?? 0);
    return authResponse;
  }

  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) async {
    return await _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }

  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    _scheduleList = await _dataSource.getSchedulesByRouteName(routeName);
    notifyListeners();
    return _scheduleList;
  }

  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    return await _dataSource.getReservationsByScheduleAndDepartureDate(
        scheduleId, departureDate);
  }

  Future<ResponseModel> addReservation(BusReservation reservation) async {
    return await _dataSource.addReservation(reservation);
  }

  Future<List<BusReservation>> getAllReservation() async {
    _reservationList = await _dataSource.getAllReservation();
    notifyListeners();
    return _reservationList;
  }

  Future<List<BusReservation>> getReservationsByMobile(String mobile) async {
    return await _dataSource.getReservationsByMobile(mobile);
  }

  List<ReservationExpansionItem> getExpansionItem(
      List<BusReservation> reservations) {
    return List.generate(reservations.length, (index) {
      final reservation = reservations[index];
      return ReservationExpansionItem(
        header: ReservationExpansionHeader(
          reservationId: reservation.reservationId,
          date: reservation.departureDate,
          busSchedule: reservation.busSchedule,
          timestamp: reservation.timestamp.toInt(),
          reservationStatus: reservation.reservationStatus,
        ),
        body: ReservationExpansionBody(
          customer: reservation.customer,
          totalSeatedBooked: reservation.totalSeatBooked,
          seatNumbers: reservation.seatNumbers,
          totalPrice: reservation.totalPrice,
        ),
      );
    });
  }

  Future<ResponseModel> addBus(Bus bus) async {
    return await _dataSource.addBus(bus);
  }

  Future<ResponseModel> addRoute(BusRoute busRoute) async {
    return await _dataSource.addRoute(busRoute);
  }

  Future<void> getAllBus() async {
    _busList = await _dataSource.getAllBus();
    notifyListeners();
  }

  Future<void> getAllRoute() async {
    _routeList = await _dataSource.getAllRoutes();
    notifyListeners();
  }

  Future<void> getAllSchedule() async {
    _scheduleList = await _dataSource.getAllSchedules();
    notifyListeners();
  }

  Future<ResponseModel> addSchedule(BusSchedule busSchedule) async {
    return await _dataSource.addSchedule(busSchedule);
  }
}
