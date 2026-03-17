import 'package:flutter/material.dart';
import 'dart:convert'; //converts JSON responses to text
import 'package:http/http.dart' as http; // library for making HTTP requests
import '../satellite.dart'; // Imports the Satellite model class
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Satellite> satellites =
      []; // empty list which will hold all the satellites once the API responds

  // Official Documentation: https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  final TextEditingController searchController =
      TextEditingController(); // controls the searching field

  String searchString = 'ISS'; // storing the default on app load string

  // dispose runs when the screen is being removed from thee memory
  // prevents memory leaks when the searchController is cleaned up
  // Official Documentation: https://api.flutter.dev/flutter/widgets/State/dispose.html
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super
        .initState(); // this piece of code is always required, its initialising the parent class
    fetchSatellites(
      searchString,
    ); // passing the default search query when app loads
  }

  Future<void> fetchSatellites(String search) async {
    // async function to allown the program to start a long running task
    final url = Uri.parse(
      'https://tle.ivanstanojevic.me/api/tle?search=$search', // using the dynamic variable
    );

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

      // print('Loaded ${satellites.length} satellites');
      // print('First satellite ${satellites[0].name}');
      // print(' ${satellites[0].satelliteId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Orbit Track'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Wrap places the widgets next to each other, Unlike Row whihc would crash the UI
          // Official Documentation: https://api.flutter.dev/flutter/widgets/Wrap-class.html
          Wrap(
            // Wrap creates a row of quich search buttons from a list with the Satellite names
            // .map() acts as a loop and goes through the list and creates and ElevatedButton for each name index
            // searchController.text updats the search bar visually
            // fetchSatellites(satelliteChoice) calls the API with the selected satellite's name
            spacing: 5,
            children: ['ISS', 'STARLINK', 'NOAA', 'HUBBLE']
                .map(
                  (satelliteChoice) => ElevatedButton(
                    onPressed: () {
                      searchController.text = satelliteChoice;
                      fetchSatellites(satelliteChoice);
                    },
                    child: Text(satelliteChoice),
                  ),
                )
                .toList(),
          ),

          // Without expanded, ListView.builder would have infinite height inside the column which would also
          // crash the program. Expanded tell the program to take all the space after the Wrap
          Expanded(
            child:
                satellites
                    .isEmpty // if is empty will show a circular progress indicator in the middle of the screen
                ? const Center(
                    child: CircularProgressIndicator(),
                  ) // shows loading spinner while the API fetches the data
                : ListView.builder(
                    // displays all the satellites from the API
                    itemCount: satellites.length, // all the satellites
                    itemBuilder: (context, index) {
                      final satellite = satellites[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        color: Colors.blue[850],
                        child: ListTile(
                          // OnTap allows the user to press each satellite and check its details
                          // Official Documentation: https://docs.flutter.dev/cookbook/navigation/navigation-basics
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailedScreen(satellite: satellite),
                              ),
                            );
                          },
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
          ),
        ],
      ),
    );
  }
}
