import 'package:flutter/material.dart';
import '../satellite.dart';

class DetailedScreen extends StatelessWidget {
  final Satellite satellite;
  const DetailedScreen({super.key, required this.satellite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[850],
        title: Text(
          satellite.name,
          style: const TextStyle(color: Colors.blueGrey),
        ),
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              satellite.name,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
