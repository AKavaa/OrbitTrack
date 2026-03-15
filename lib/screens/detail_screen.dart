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

      body: SingleChildScrollView(
        // SingleChildScrollView to be able to scroll
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // rounded Card
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(
                      Icons.satellite_alt,
                      color: Colors.blueGrey,
                      size: 40,
                    ),
                    const SizedBox(width: 14), // space between text and icon
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            satellite.name,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12), // space between the data
                          Text(
                            'Satellite ID: ${satellite.satelliteId}',
                            style: TextStyle(color: Colors.blueGrey),
                          ),

                          Text(
                            'Last Updated: ${satellite.date}',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12), // space between the data
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // rounded Card
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const SizedBox(width: 14), // space between text and icon
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Satellite Raw Data',
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12), // space between the data
                          Text(
                            'Line 1: ${satellite.line1}',
                            style: TextStyle(color: Colors.blueGrey),
                          ),

                          const SizedBox(
                            height: 14,
                          ), // space between text and icon

                          Text(
                            'Line 2: ${satellite.line2}',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
