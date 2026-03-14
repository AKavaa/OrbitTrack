import 'package:flutter/material.dart';
import 'dart:convert'; //converts JSON responses to text
import 'package:http/http.dart' as http; // library for making HTTP requests
import '../satellite.dart'; // Imports the Satellite model class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orbit Track',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Orbit Track'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Satellite> satellites =
      []; // empty list which will hold all the satellites once the API responds
  @override
  void initState() {
    super
        .initState(); // this piece of code is always required, its initialising the parent class
    fetchSatellites();
  }

  Future<void> fetchSatellites() async {
    // async function to allown the program to start a long running task
    final url = Uri.parse('https://tle.ivanstanojevic.me/api/tle?search=ISS');

    final response = await http.get(
      url,
    ); // await -> pauses until the server responds

    if (response.statusCode == 200) {
      // request succesfull
      final data = jsonDecode(
        response.body,
      ); // response.body by default is a raw JSON string, jsonDecode turns it into a Dart Map
      setState(() {
        satellites = (data['member'] as List)
            .map((item) => Satellite.fromJson(item))
            .toList();
      });

      print('Loaded ${satellites.length} satellites');
      print('First satellite ${satellites[0].name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(backgroundColor: Colors.white, title: Text(widget.title)),
      body:
          satellites
              .isEmpty // if is empty will show a circular progress indicator in the middle of the screen
          ? const Center(
              child: CircularProgressIndicator(),
            ) // shows loading spinner while the API fetches the data
          : ListView.builder(
              // displays all the satellites from the API
              itemCount: satellites.length,
              itemBuilder: (context, index) {
                final satellite = satellites[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  color: Colors.blue[850],
                  child: ListTile(
                    leading: const Icon(
                      Icons.satellite_alt,
                      color: Colors.blueGrey,
                    ), // in build satellite icon with white color
                    title: Text(
                      satellite.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    subtitle: Text(
                      'ID ${satellite.satelliteId} ',
                      style: TextStyle(color: Colors.blueGrey[400]),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
