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
  // Base URL for the API endpoints
  final _baseUrl = 'http://localhost:8080/api/';

  // Headers for requests that do not require authentication
  Map<String, String> get header => {
        'Content-Type': 'application/json',
      };

  // Headers for requests that require authentication, including a Bearer token
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
    // Constructs the URL for adding a bus
    final url = '$_baseUrl${'bus/add'}';
    try {
      // Sends a POST request to add a bus with authentication headers
      final response = await http.post(
        Uri.parse(url),
        headers: await authHeader,
        body: jsonEncode(bus.toJson()),
      );
      // Processes the response and returns a ResponseModel
      return await _getResponse(response);
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addReservation(BusReservation reservation) async {
    // Constructs the URL for adding a reservation
    final url = '$_baseUrl${'reservations/add'}';
    try {
      // Sends a POST request to add a reservation without authentication headers
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(reservation.toJson()),
      );
      // Processes the response and returns a ResponseModel
      return await _getResponse(response);
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addRoute(BusRoute busRoute) async {
    // Constructs the URL for adding a bus route
    final url = '$_baseUrl${'bus-route/add'}';
    try {
      // Sends a POST request to add a bus route with authentication headers
      final response = await http.post(
        Uri.parse(url),
        headers: await authHeader,
        body: jsonEncode(busRoute.toJson()),
      );
      // Processes the response and returns a ResponseModel
      return await _getResponse(response);
    } catch (error) {
      // Prints the error and rethrows it
      print(error.toString());
      rethrow;
    }
  }

  @override
  Future<ResponseModel> addSchedule(BusSchedule busSchedule) async {
    // Constructs the URL for adding a bus schedule
    final url = '$_baseUrl${'bus-schedule/add'}';
    try {
      // Sends a POST request to add a bus schedule with authentication headers
      final response = await http.post(
        Uri.parse(url),
        headers: await authHeader,
        body: jsonEncode(busSchedule.toJson()),
      );
      // Processes the response and returns a ResponseModel
      return await _getResponse(response);
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<List<Bus>> getAllBus() async {
    // Constructs the URL for retrieving all buses
    final url = '$_baseUrl${'bus/all'}';
    try {
      // Sends a GET request to retrieve all buses
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parses the response body and returns a list of Bus objects
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => Bus.fromJson(mapList[index]));
      }
      // Returns an empty list if the response status is not 200
      return [];
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<List<BusReservation>> getAllReservation() async {
    // Constructs the URL for retrieving all reservations
    final url = '$_baseUrl${'reservations/all'}';
    try {
      // Sends a GET request to retrieve all reservations
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parses the response body and returns a list of BusReservation objects
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      // Returns an empty list if the response status is not 200
      return [];
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<List<BusRoute>> getAllRoutes() async {
    // Constructs the URL for retrieving all bus routes
    final url = '$_baseUrl${'bus-route/all'}';
    try {
      // Sends a GET request to retrieve all bus routes
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parses the response body and returns a list of BusRoute objects
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusRoute.fromJson(mapList[index]));
      }
      // Returns an empty list if the response status is not 200
      return [];
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<List<BusSchedule>> getAllSchedules() async {
    // Constructs the URL for retrieving all bus schedules
    final url = '$_baseUrl${'bus-schedule/all'}';
    try {
      // Sends a GET request to retrieve all bus schedules
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parses the response body and returns a list of BusSchedule objects
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusSchedule.fromJson(mapList[index]));
      }
      // Returns an empty list if the response status is not 200
      return [];
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<List<BusReservation>> getReservationsByMobile(String mobile) async {
    // Constructs the URL for retrieving reservations by mobile number
    final url = '$_baseUrl${'reservations/mobile/$mobile'}';
    try {
      // Sends a GET request to retrieve reservations by mobile number
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parses the response body and returns a list of BusReservation objects
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      // Returns an empty list if the response status is not 200
      return [];
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    // Constructs the URL for retrieving reservations by schedule ID and departure date
    final url =
        '$_baseUrl${'reservations/bus-schedule/$scheduleId/departure-date/$departureDate'}';
    try {
      // Sends a GET request to retrieve reservations by schedule ID and departure date
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parses the response body and returns a list of BusReservation objects
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusReservation.fromJson(mapList[index]));
      }
      // Returns an empty list if the response status is not 200
      return [];
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) async {
    // Constructs the URL for retrieving a bus route by city from and city to
    final url = '$_baseUrl${'bus-route/city-from-to/$cityFrom/$cityTo'}';
    try {
      // Sends a GET request to retrieve a bus route by city from and city to
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parses the response body and returns a BusRoute object
        final map = jsonDecode(response.body);
        return BusRoute.fromJson(map);
      }
      // Returns null if the response status is not 200
      return null;
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  @override
  Future<BusRoute?> getRouteByRouteName(String routeName) {
    // Placeholder for future implementation of retrieving a bus route by route name
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    // Constructs the URL for retrieving bus schedules by route name
    final url = '$_baseUrl${'bus-schedule/route/$routeName'}';
    try {
      // Sends a GET request to retrieve bus schedules by route name
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parses the response body and returns a list of BusSchedule objects
        final mapList = jsonDecode(response.body) as List;
        return List.generate(
            mapList.length, (index) => BusSchedule.fromJson(mapList[index]));
      }
      // Returns an empty list if the response status is not 200
      return [];
    } catch (error) {
      // Rethrows any caught errors
      rethrow;
    }
  }

  Future<ResponseModel> _getResponse(http.Response response) async {
    // Initialize the response status to NONE
    ResponseStatus status = ResponseStatus.NONE;
    // Create an empty ResponseModel object
    ResponseModel responseModel = ResponseModel();

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Set the status to SAVED
      status = ResponseStatus.SAVED;
      // Parse the response body into a ResponseModel object
      responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      // Update the response status in the ResponseModel
      responseModel.responseStatus = status;
    }
    // Check if the response status code is 401 (Unauthorized) or 403 (Forbidden)
    else if (response.statusCode == 401 || response.statusCode == 403) {
      // Check if the token has expired
      if (await hasTokenExpired()) {
        // Set the status to EXPIRED if the token has expired
        status = ResponseStatus.EXPIRED;
      } else {
        // Otherwise, set the status to UNAUTHORIZED
        status = ResponseStatus.UNAUTHORIZED;
      }
      // Create a ResponseModel with the unauthorized status and message
      responseModel = ResponseModel(
        responseStatus: status,
        statusCode: response.statusCode,
        message: 'Unauthorized',
      );
    }
    // Check if the response status code is 500 (Internal Server Error) or 400 (Bad Request)
    else if (response.statusCode == 500 || response.statusCode == 400) {
      // Parse the response body into an ErrorDetailsModel object
      final json = jsonDecode(response.body);
      final errorDetails = ErrorDetailsModel.fromJson(json);
      // Set the status to ERROR
      status = ResponseStatus.ERROR;
      // Create a ResponseModel with the error status and message from the error details
      responseModel = ResponseModel(
        responseStatus: status,
        statusCode: 500,
        message: errorDetails.errorMessage,
      );
    }
    // Return the constructed ResponseModel
    return responseModel;
  }
}
