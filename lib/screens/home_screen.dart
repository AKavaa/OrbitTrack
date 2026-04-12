import 'package:flutter/material.dart';
import 'dart:convert'; //converts JSON responses to text
import 'package:http/http.dart' as http; // library for making HTTP requests
import '../satellite.dart'; // Imports the Satellite model class
import 'detail_screen.dart';
import 'splash_screen.dart';

class HomeScreen extends StatefulWidget {
  // receives toggleTheme function from main.dart
  // Docs: https://api.flutter.dev/flutter/foundation/VoidCallback.html
  final VoidCallback toggleTheme;
  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Satellite> cachedSatellites =
      []; //stores the last succesfull API result in memory
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

  String errorMessage = '';

  Future<void> fetchSatellites(String search) async {
    // try and catch handle the network errors without the app crashing
    // Official Documentation: https://dart.dev/language/error-handling
    try {
      final url = Uri.parse(
        'https://tle.ivanstanojevic.me/api/tle?search=$search',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        // request succesfull
        final data = jsonDecode(
          response.body,
        ); // response.body by default is a raw JSON string, jsonDecode turns it into a Dart Map
        setState(() {
          errorMessage = '';
          satellites = (data['member'] as List)
              .map((item) => Satellite.fromJson(item))
              .toList();

          cachedSatellites =
              satellites; // each time the API succeeds it gets saves into this variable
        });
      }
    } catch (error) {
      setState(() {
        if (cachedSatellites.isNotEmpty) {
          satellites = cachedSatellites;
          errorMessage = 'No Internet Connection, Showing the last results!';
        } else {
          errorMessage = 'No Internet Connection, App Is Offline!';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Orbit Track'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          if (errorMessage.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(7),
              color: Colors.redAccent,
              child: Text(errorMessage, textAlign: TextAlign.center),
            ),

          // TextField was adapted from Flutter Official Docs: https://api.flutter.dev/flutter/material/TextField-class.html
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,

              style: const TextStyle(
                color: Colors.white,
              ), // this controls the color of the text inside teh input field
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Search Satellites...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ), // adding a search icon
              ),

              onSubmitted:
                  (
                    satelliteValue,
                  ) => // satelliteValue is whatever is typed and .trim() removes any whitespaces
                      fetchSatellites(satelliteValue.trim()),
            ),
          ),
          // Wrap places the widgets next to each other, Unlike Row whihc would crash the UI
          // Official Documentation: https://api.flutter.dev/flutter/widgets/Wrap-class.html
          Wrap(
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

          // Expanded fills remaining space after Wrap
          // Official Documentation: https://api.flutter.dev/flutter/widgets/Expanded-class.html
          Expanded(
            child:
                satellites
                    .isEmpty  && errorMessage.isEmpty// if is empty will show a circular progress indicator in the middle of the screen
                ? const Center(
                    child: CircularProgressIndicator(),
                  ) 
                  :  satellites
                    .isEmpty  && errorMessage.isNotEmpty
                    ? Center(
                      child: Text(
                        errorMessage,
                        style: const TextStyle(
                          fontSize:14,
                        ),
                      ),
                    )
                    // shows loading spinner while the API fetches the data
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
                                    DetailedScreen(satellite: satellite, toggleTheme: widget.toggleTheme),
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