import 'package:flutter/material.dart';
import '../satellite.dart';

class DetailedScreen extends StatelessWidget {
  final Satellite satellite;
  final VoidCallback toggleTheme;
  const DetailedScreen({super.key, required this.satellite, required this.toggleTheme});

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
  iconTheme: const IconThemeData(color: Colors.blueGrey),
  actions: [
    IconButton(
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
      onPressed: toggleTheme,
    ),
  ],
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
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
                          ),

                          const SizedBox(
                            height: 14,
                          ), // space between text and icon

                          Text(
                            'Line 2: ${satellite.line2}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
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
                            'Orbital Data',
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12), // space between the data
                          Text(
                            'Inclination: ${satellite.inclination}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ), // space between text and icon

                          Text(
                            'RAAN: ${satellite.raan}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ), // space between text and icon

                          Text(
                            'Eccentricity: ${satellite.eccentricity}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ), // space between text and icon

                          Text(
                            'Mean Motion: ${satellite.meanMotion}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
                          ),

                          const SizedBox(
                            height: 40,
                          ), // space between text and icon

                          Text(
                            'Definition',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
                          ),
                          const SizedBox(height: 10), // spa
                          Text(
                            'Inclination: Angle of the Orbit which is relative to the Equator',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
                          ),
                          const SizedBox(height: 10), // spa
                          Text(
                            'RAAN: is the angle measured eastward along the Earths equatorial plane from the First Point of Aries (vernal equinox, a reference direction in space) to the ascending node ',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
                          ),
                          const SizedBox(height: 10), // spa
                          Text(
                            'Eccentricity: a dimensionless parameter that describes how much an orbit deviates from a perfect circle ',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
                          ),

                          const SizedBox(height: 10), // spa
                          Text(
                            'Mean Motion: represents the average angular velocity of a satellite, measured in revolutions per day, indicating how many times it orbits Earth in 24 hours ',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'RobotoMono-Regular',
                            ),
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
