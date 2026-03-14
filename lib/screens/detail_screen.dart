import 'package:flutter/material.dart';
import '../satellite.dart'; // import our Satellite model

class DetailScreen extends StatelessWidget {
  // satellite is passed in from the home screen when user taps a card
  // this is how Flutter passes data between screens
  // Docs: https://docs.flutter.dev/cookbook/navigation/passing-data
  final Satellite satellite;

  const DetailScreen({super.key, required this.satellite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        // back button is automatic when you use Navigator.push
        title: Text(
          satellite.name,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView makes the whole page scrollable
        // Docs: https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // satellite icon and name at top
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.satellite_alt,
                    color: Colors.white,
                    size: 80,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    satellite.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NORAD ID: ${satellite.satelliteId}',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Last updated: ${satellite.date}',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Raw TLE data section
            _SectionTitle(title: 'Raw TLE Data'),
            const SizedBox(height: 8),
            _TleDataCard(label: 'Line 1', value: satellite.line1),
            const SizedBox(height: 8),
            _TleDataCard(label: 'Line 2', value: satellite.line2),

            const SizedBox(height: 24),

            // Orbital parameters section
            _SectionTitle(title: 'Orbital Parameters'),
            const SizedBox(height: 8),

            // each row shows one orbital parameter
            _ParameterRow(
              label: 'Inclination',
              value: '51.63°',
              description: 'Angle of orbit relative to equator',
            ),
            _ParameterRow(
              label: 'Eccentricity',
              value: '0.0007884',
              description: 'How elliptical the orbit is (0 = perfect circle)',
            ),
            _ParameterRow(
              label: 'Mean Motion',
              value: '15.48 rev/day',
              description: 'How many orbits completed per day',
            ),
            _ParameterRow(
              label: 'Epoch',
              value: satellite.date,
              description: 'Date and time this TLE data was recorded',
            ),
          ],
        ),
      ),
    );
  }
}

// reusable widget for section titles
// making it a separate widget keeps the code clean and readable
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// reusable widget for displaying raw TLE lines
class _TleDataCard extends StatelessWidget {
  final String label;
  final String value;
  const _TleDataCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          // monospace font makes TLE data easier to read
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// reusable widget for each orbital parameter row
class _ParameterRow extends StatelessWidget {
  final String label;
  final String value;
  final String description;

  const _ParameterRow({
    required this.label,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // label and description on the left
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          // value on the right
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
