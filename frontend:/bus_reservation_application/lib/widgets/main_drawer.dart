import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.grey,
          ),
          ListTile(
            leading: const Icon(Icons.directions_bus),
            title: const Text('Add Bus'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameAddBusPage);
            },
          ),
          ListTile(
            leading: const Icon(Icons.route),
            title: const Text('Add Route'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameAddRoutePage);
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Add Schedule'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameAddSchedulePage);
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('View Reservations'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameReservationPage);
            },
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text('Admin Login'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameLoginPage);
            },
          ),
        ],
      ),
    );
  }
}
