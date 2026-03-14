import 'package:flutter/material.dart';
import 'dart:convert'; //converts JSON responses to text
import 'package:http/http.dart' as http; // library for making HTTP requests

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
  @override
  void initState() {
    super
        .initState(); // this piece of code is always required, its initialising the parent class
    fetchSatellites();
  }

  Future<void> fetchSatellites() async {
    // async function to allown the program to start a long running task
    final URL = Uri.parse('https://tle.ivanstanojevic.me/api/tle?search=ISS');

    final response = await http.get(
      URL,
    ); // await -> pauses until the server responds

    if (response.statusCode == 200) {
      // request succesfull
      final data = jsonDecode(
        response.body,
      ); // response.body by default is a raw JSON string, jsonDecode turns it into a Dart Map
      print(response.body);
    } else {
      print('API ERROR - status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(backgroundColor: Colors.white, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Orbit Track!',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
