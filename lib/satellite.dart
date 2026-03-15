// initialise a class to store the needed data which will be fetched from the API
class Satellite {
  final int satelliteId;
  final String name;
  final String date;
  final String line1;
  final String line2;

  // Constructor is required because every field must be provided when the satellite is created
  // Documentation reference: https://dart.dev/language/constructors
  Satellite({
    required this.satelliteId,
    required this.name,
    required this.date,
    required this.line1,
    required this.line2,
  });

  // Factory constructor returns returns an instance of the class built from a JSON map
  // Standard Flutter pattern to parse any API response
  // Documentation reference: https://dart.dev/language/constructors#factory-constructors
  factory Satellite.fromJson(Map<String, dynamic> json) {
    return Satellite(
      // If SatelliteId is null, default to 0
      // int? this could be null and the ? symbol makes it nullable
      satelliteId:
          json['satelliteId'] as int? ??
          0, // if its null, this -> ?? -> means use 0 rather than crash the program
      //Documentation reference: https://dart.dev/null-safety
      name: json['name'] as String? ?? 'Null',
      date: json['date'] as String? ?? '',
      line1: json['line1'] as String? ?? '',
      line2: json['line2'] as String? ?? '',
    );
  }
  // Using getters to get the real numbers and real data from the API,
  // The data is in fixed width so its more accurate to collect the data
  // we use double because the orbital data are decimal numbers
  // we need only the line2 because there is the data that we need for the orbital parameters, the numbers in the brackets is the start and the end of the parameters we need to be displayed
  // trim is to not count any whitespaces, basically removing them, and ?? 0.0 is if null or data isnt fetced correctly to retrieve 0.0 instead of null

  double get inclination {
    // inclination is at characters 8 - 16
    return double.tryParse(line2.substring(8, 16).trim()) ?? 0.0;
  }

  double get raan {
    // raan is at characters 17 - 25
    return double.tryParse(line2.substring(17, 25).trim()) ?? 0.0;
  }

  double get eccentricity {
    // eccentricity is at characters 26 - 33, added 0. cause the value implied a decimal point and without it the number is wrongly fetched
    // for example, was 2464 -> now is 0.0002464, more accurate
    return double.tryParse('0.${line2.substring(26, 33).trim()}') ?? 0.0;
  }

  double get meanMotion {
    // meanMotion is at characters 52 - 63
    return double.tryParse(line2.substring(52, 63).trim()) ?? 0.0;
  }
}
