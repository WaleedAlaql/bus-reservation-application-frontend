import 'package:bus_reservation_application/utils/colors.dart';
import 'package:bus_reservation_application/utils/constants.dart';
import 'package:flutter/material.dart';

class SeatPlanView extends StatelessWidget {
  const SeatPlanView({
    super.key,
    required this.totalSeats,
    required this.bookedSeatNumbers,
    required this.totalSeatBooked,
    required this.isBusinessClass,
    required this.onSeatSelected,
  });
  final int totalSeats;
  final String bookedSeatNumbers;
  final int totalSeatBooked;
  final bool isBusinessClass;
  final Function(bool, String) onSeatSelected;

  @override
  Widget build(BuildContext context) {
    // Calculate number of rows based on total seats and seating class
    // Business class: 3 seats per row, Economy: 4 seats per row
    final numberOfRows =
        (isBusinessClass ? totalSeats / 3 : totalSeats / 4).toInt();

    // Set number of columns based on seating class
    final numberOfColumns = isBusinessClass ? 3 : 4;

    // Create 2D array to store seat labels (e.g. A1, A2, B1, B2, etc.)
    List<List<String>> seatArrangement = [];

    // Generate seat labels for each row and column
    for (int i = 0; i < numberOfRows; i++) {
      List<String> column = [];
      for (int j = 0; j < numberOfColumns; j++) {
        // Combine row letter (A,B,C...) with column number (1,2,3...)
        column.add('${seatLabelList[i]}${j + 1}');
      }
      seatArrangement.add(column);
    }

    // Convert comma-separated booked seats string into a list
    // Example: "A1,B3,C2" becomes ["A1", "B3", "C2"]
    final List<String> bookedSeatNumbersList =
        bookedSeatNumbers.isEmpty ? [] : bookedSeatNumbers.split(',');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Front',
            style: TextStyle(
              fontSize: 30,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.black,
          ),
          Column(children: [
            // Iterate through each row in the seat arrangement
            for (int i = 0; i < seatArrangement.length; i++)
              Row(mainAxisSize: MainAxisSize.min, children: [
                // Iterate through each seat in the current row
                for (int j = 0; j < seatArrangement[i].length; j++)
                  Row(
                    children: [
                      // Create individual seat widget with its label and booking status
                      Seat(
                        label: seatArrangement[i][j],
                        isBooked: bookedSeatNumbersList
                            .contains(seatArrangement[i][j]),
                        onSelect: (isSelected) {
                          onSeatSelected(isSelected, seatArrangement[i][j]);
                        },
                      ),
                      // Add aisle spacing:
                      // For business class: after first seat (j == 0)
                      if (isBusinessClass && j == 0) const SizedBox(width: 24),
                      // For economy class: after second seat (j == 1)
                      if (!isBusinessClass && j == 1) const SizedBox(width: 24),
                    ],
                  )
              ])
          ]),
        ],
      ),
    );
  }
}

class Seat extends StatefulWidget {
  const Seat({
    super.key,
    required this.label,
    required this.isBooked,
    required this.onSelect,
  });
  final String label;
  final bool isBooked;
  final Function(bool) onSelect;

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isBooked
          ? null
          : () {
              setState(() {
                isSelected = !isSelected;
              });
              widget.onSelect(isSelected);
            },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 50,
        width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.isBooked
              ? seatBookedColor
              : isSelected
                  ? seatSelectedColor
                  : seatAvailableColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: widget.isBooked
              ? null
              : [
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(4, 4),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade800,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
