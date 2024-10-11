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
    final numberOfRows =
        (isBusinessClass ? totalSeats / 3 : totalSeats / 4).toInt();
    final numberOfColumns = isBusinessClass ? 3 : 4;
    List<List<String>> seatArrangement = [];
    for (int i = 0; i < numberOfRows; i++) {
      List<String> column = [];
      for (int j = 0; j < numberOfColumns; j++) {
        column.add('${seatLabelList[i]}${j + 1}');
      }
      seatArrangement.add(column);
    }
    final List<String> bookedSeatNumbersList =
        bookedSeatNumbers.isEmpty ? [] : bookedSeatNumbers.split(',');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 2,
            color: Colors.black,
          ),
          Column(children: [
            for (int i = 0; i < seatArrangement.length; i++)
              Row(mainAxisSize: MainAxisSize.min, children: [
                for (int j = 0; j < seatArrangement[i].length; j++)
                  Row(
                    children: [
                      Seat(
                        label: seatArrangement[i][j],
                        isBooked: bookedSeatNumbersList
                            .contains(seatArrangement[i][j]),
                        onSelect: (isSelected) {
                          onSeatSelected(isSelected, seatArrangement[i][j]);
                        },
                      ),
                      if (isBusinessClass && j == 0) const SizedBox(width: 24),
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
        margin: const EdgeInsets.all(10),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: widget.isBooked
              ? seatBookedColor
              : isSelected
                  ? seatSelectedColor
                  : seatAvailableColor,
          borderRadius: BorderRadius.circular(10),
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
