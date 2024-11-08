import 'package:bus_reservation_application/models/reservation_expansion_item.dart';
import 'package:bus_reservation_application/providers/app_data_provider.dart';
import 'package:bus_reservation_application/utils/helper_functions.dart';
import 'package:bus_reservation_application/widgets/reservation_item_body_view.dart';
import 'package:bus_reservation_application/widgets/reservation_item_header_view.dart';
import 'package:bus_reservation_application/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  bool isFirstTime = true;
  List<ReservationExpansionItem> items = [];

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      getData();
    }
    super.didChangeDependencies();
  }

  getData() async {
    // Fetch all reservations from the AppDataProvider
    final data = await Provider.of<AppDataProvider>(context, listen: false)
        .getAllReservation();

    // Convert the fetched data into a list of ReservationExpansionItem
    items = Provider.of<AppDataProvider>(context, listen: false)
        .getExpansionItem(data);

    // Update the UI to reflect the new data
    setState(() {});
  }

  void search(String mobile) async {
    // Fetch reservations by mobile number from the AppDataProvider
    final data = await Provider.of<AppDataProvider>(context, listen: false)
        .getReservationsByMobile(mobile);

    // Check if no reservations were found
    if (data.isEmpty) {
      // Display a message indicating no reservations were found
      showMessage(context, 'No reservations found');
      return;
    } else {
      // Update the UI with the fetched reservations
      setState(() {
        items = Provider.of<AppDataProvider>(context, listen: false)
            .getExpansionItem(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBox(
              onSubmit: search,
            ),
            ExpansionPanelList(
              // Define a callback to handle panel expansion and collapse
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  // Update the isExpanded property of the tapped panel
                  items[panelIndex].isExpanded = isExpanded;
                });
              },
              // Map each item to an ExpansionPanel widget
              children: items
                  .map(
                    (item) => ExpansionPanel(
                      // Set the expansion state of the panel
                      isExpanded: item.isExpanded,
                      // Define the header of the panel using a custom widget
                      headerBuilder: (context, isExpanded) =>
                          ReservationItemHeaderView(header: item.header),
                      // Define the body of the panel using a custom widget
                      body: ReservationItemBodyView(body: item.body),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
