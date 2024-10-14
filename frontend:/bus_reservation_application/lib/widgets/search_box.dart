import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key, required this.onSearch});

  final Function(String) onSearch;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onSubmitted: (value) {
          if (searchController.text.isEmpty) {
            return;
          }
          widget.onSearch(searchController.text);
        },
      ),
    );
  }
}
