import 'package:flutter/material.dart';

class NoRoute extends StatelessWidget {
  const NoRoute({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(title),
      ),
      body: const Center(
        child: Text('No route defined.'),
      ),
    );
  }
}
