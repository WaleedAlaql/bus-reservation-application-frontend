import 'package:flutter/material.dart';

class AddRoutePage extends StatefulWidget {
  const AddRoutePage({super.key});

  @override
  State<AddRoutePage> createState() => _AddRoutePageState();
}

class _AddRoutePageState extends State<AddRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Route'),
      ),
    );
  }
}
