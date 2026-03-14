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
}
