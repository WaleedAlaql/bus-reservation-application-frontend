import 'dart:io';

import 'package:bus_reservation_application/datasource/data_source.dart';
import 'package:bus_reservation_application/models/app_user.dart';
import 'package:bus_reservation_application/models/auth_response_model.dart';
import 'package:bus_reservation_application/models/bus_model.dart';
import 'package:bus_reservation_application/models/bus_reservation.dart';
import 'package:bus_reservation_application/models/bus_schedule.dart';
import 'package:bus_reservation_application/models/but_route.dart';
import 'package:bus_reservation_application/models/error_details_model.dart';
import 'package:bus_reservation_application/models/response_model.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:bus_reservation_application/utils/helper_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppDataSource extends DataSource {
  final _baseUrl = 'http://localhost:8080/api/';

  Map<String, String> get header => {
        'Content-Type': 'application/json',
      };
  Future<Map<String, String>> get authHeader async => {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${await getToken()}',
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
      final authResponse = AuthResponseModel.fromJson(map);
      return authResponse;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<ResponseModel> addBus(Bus bus) async {
    final url = '$_baseUrl${'bus/add'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: await authHeader,
        body: jsonEncode(bus.toJson()),
      );
      return await _getResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addReservation(BusReservation reservation) async {
    final url = '$_baseUrl${'reservations/add'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(reservation.toJson()),
      );
      return await _getResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addRoute(BusRoute busRoute) async {
    final url = '$_baseUrl${'bus-route/add'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: await authHeader,
        body: jsonEncode(busRoute.toJson()),
      );
      return await _getResponse(response);
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addSchedule(BusSchedule busSchedule) async {
    final url = '$_baseUrl${'bus-schedule/add'}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: await authHeader,
        body: jsonEncode(busSchedule.toJson()),
      );
      return await _getResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<Bus>> getAllBus() async {
    final url = '$_baseUrl${'bus/all'}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => Bus.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BusReservation>> getAllReservation() {
    // TODO: implement getAllReservation
    throw UnimplementedError();
  }

  @override
  Future<List<BusRoute>> getAllRoutes() async {
    final url = '$_baseUrl${'bus-route/all'}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusRoute.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BusSchedule>> getAllSchedules() async {
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
      int scheduleId, String departureDate) async {
    final url =
        '$_baseUrl${'reservations/bus-schedule/$scheduleId/departure-date/$departureDate'}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) async {
    final url = '$_baseUrl${'bus-route/city-from-to/$cityFrom/$cityTo'}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);
        return BusRoute.fromJson(map);
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BusRoute?> getRouteByRouteName(String routeName) {
    // TODO: implement getRouteByRouteName
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    final url = '$_baseUrl${'bus-schedule/route/$routeName'}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusSchedule.fromJson(mapList[index]));
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  Future<ResponseModel> _getResponse(http.Response response) async {
    ResponseStatus status = ResponseStatus.NONE;
    ResponseModel responseModel = ResponseModel();
    if (response.statusCode == 200) {
      status = ResponseStatus.SAVED;
      responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      responseModel.responseStatus = status;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      if (await hasTokenExpired()) {
        status = ResponseStatus.EXPIRED;
      } else {
        status = ResponseStatus.UNAUTHORIZED;
      }
      responseModel = ResponseModel(
        responseStatus: status,
        statusCode: response.statusCode,
        message: 'Unauthorized',
      );
    } else if (response.statusCode == 500 || response.statusCode == 400) {
      final json = jsonDecode(response.body);
      final errorDetails = ErrorDetailsModel.fromJson(json);
      status = ResponseStatus.ERROR;
      responseModel = ResponseModel(
        responseStatus: status,
        statusCode: 500,
        message: errorDetails.errorMessage,
      );
    }
    return responseModel;
  }
}
