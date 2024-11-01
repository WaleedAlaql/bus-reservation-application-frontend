import 'package:bus_reservation_application/datasource/data_source.dart';
import 'package:bus_reservation_application/models/app_user.dart';
import 'package:bus_reservation_application/models/auth_response_model.dart';
import 'package:bus_reservation_application/models/bus_model.dart';
import 'package:bus_reservation_application/models/bus_reservation.dart';
import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/models/but_route.dart';
import 'package:bus_reservation_application/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppDataSource extends DataSource {
  final _baseUrl = 'http://localhost:8080/api/';

  Map<String, String> get header => {
        'Content-Type': 'application/json',
      };

  /// Authenticates a user by sending their credentials to the server
  ///
  /// [user] - The AppUser object containing login credentials
  ///
  /// Returns an [AuthResponseModel] containing the authentication result and user data
  /// Returns null if the authentication request fails
  @override
  Future<AuthResponseModel?> login(AppUser user) async {
    final url = '$_baseUrl${'auth/login'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(user.toJson()),
      );
      final map = jsonDecode(response.body);
      print('Response JSON: $map');
      final authResponse = AuthResponseModel.fromJson(map);
      return authResponse;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  @override
  Future<ResponseModel> addBus(Bus bus) {
    // TODO: implement addBus
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> addReservation(BusReservation reservation) {
    // TODO: implement addReservation
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> addRoute(BusRoute busRoute) {
    // TODO: implement addRoute
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> addSchedule(BusSchedule busSchedule) {
    // TODO: implement addSchedule
    throw UnimplementedError();
  }

  @override
  Future<List<Bus>> getAllBus() {
    // TODO: implement getAllBus
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getAllReservation() {
    // TODO: implement getAllReservation
    throw UnimplementedError();
  }

  @override
  Future<List<BusRoute>> getAllRoutes() {
    // TODO: implement getAllRoutes
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getAllSchedules() {
    // TODO: implement getAllSchedules
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByMobile(String mobile) {
    // TODO: implement getReservationsByMobile
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) {
    // TODO: implement getReservationsByScheduleAndDepartureDate
    throw UnimplementedError();
  }

  @override
  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) {
    // TODO: implement getRouteByCityFromAndCityTo
    throw UnimplementedError();
  }

  @override
  Future<BusRoute?> getRouteByRouteName(String routeName) {
    // TODO: implement getRouteByRouteName
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) {
    // TODO: implement getSchedulesByRouteName
    throw UnimplementedError();
  }
}
