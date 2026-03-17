import 'package:flutter/material.dart';
import 'home_screen.dart'; // importing the Home Screen to navigate to it after

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.satellite_alt, color: Colors.blueGrey, size: 40),

            const SizedBox(height: 14),

            const Text(
              'ORBIT TRACK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              'Real Time Satellite Tracking',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            const SizedBox(height: 120),

            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // rounded Card
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'What is TLE?',
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      'A Two-Line Element set (TLE) is a data format used to describe the orbital elements of an orbiting object (like a satellite or space debris) around the Earth at a specific time. It is used in software to predict where an object will be in the future, providing a "space address" for tracking and orbital mechanics. ',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 180),

            SizedBox(
              //https://docs.flutter.dev/cookbook/navigation/navigation-basics
              // adding a button and when pressed moves to the HomeScreen
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text('Explore Satellites!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
