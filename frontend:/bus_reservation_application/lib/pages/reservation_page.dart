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
  void initState() {
    if (isFirstTime) {
      getData();
      isFirstTime = false;
    }
    super.initState();
  }

  getData() async {
    final data = await Provider.of<AppDataProvider>(context, listen: false)
        .getAllReservation();
    items = Provider.of<AppDataProvider>(context, listen: false)
        .getExpansionItem(data);
    setState(() {});
  }

  void search(String mobile) async {
    final data = await Provider.of<AppDataProvider>(context, listen: false)
        .getReservationsByMobile(mobile);
    if (data.isEmpty) {
      showMessage(context, 'No reservations found');
      return;
    } else {
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
              onSearch: search,
            ),
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  items[panelIndex].isExpanded = !isExpanded;
                });
              },
              children: items
                  .map(
                    (item) => ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: (context, isExpanded) =>
                          ReservationItemHeaderView(header: item),
                      body: ReservationItemBodyView(body: item),
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
