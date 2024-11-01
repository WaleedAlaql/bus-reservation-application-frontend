import 'package:bus_reservation_application/pages/add_bus_page.dart';
import 'package:bus_reservation_application/pages/add_route_page.dart';
import 'package:bus_reservation_application/pages/add_schedule_page.dart';
import 'package:bus_reservation_application/pages/login_page.dart';
import 'package:bus_reservation_application/pages/reservation_page.dart';
import 'package:bus_reservation_application/pages/search_page.dart';
import 'package:bus_reservation_application/pages/search_result_page.dart';
import 'package:bus_reservation_application/pages/seat_selection_page.dart';
import 'package:bus_reservation_application/pages/booking_confirmation_page.dart';
import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppDataProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: routeNameHome,
      routes: {
        routeNameHome: (context) => const SearchPage(),
        routeNameSearchResultPage: (context) => const SearchResultPage(),
        routeNameSeatSelectionPage: (context) => const SeatSelectionPage(),
        routeNameBookingConfirmationPage: (context) =>
            const BookingConfirmationPage(),
        routeNameAddBusPage: (context) => const AddBusPage(),
        routeNameAddRoutePage: (context) => const AddRoutePage(),
        routeNameAddSchedulePage: (context) => const AddSchedulePage(),
        routeNameLoginPage: (context) => const LoginPage(),
        routeNameReservationPage: (context) => const ReservationPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Bus Reservation Application',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.dark,
      ),
      home: const SearchPage(),
    );
  }
}
