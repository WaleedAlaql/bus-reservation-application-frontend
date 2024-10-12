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
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.dark,
      ),
      home: const SearchPage(),
    );
  }
}
