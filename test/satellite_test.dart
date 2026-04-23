// Official Flutter testing Documentation: https://docs.flutter.dev/testing/overview

import 'package:flutter_test/flutter_test.dart';
import 'package:orbit_track/satellite.dart';

void main() {
  // group organises related tests together
  // Docs: https://api.flutter.dev/flutter/flutter_test/group.html
  group('Satellite Model Tests', () {
    // TEST 1 - verify fromJson correctly parses API response
    test('fromJson creates a Satellite from the JSON map', () {
      // arrange - create a mock JSON response matching the API structure
      final json = {
        'satelliteId': 25544,
        'name': 'ISS (ZARYA)',
        'date': '2026-03-13T16:59:24+00:00',
        'line1':
            '1 25544U 98067A   26072.70791847  .00011780  00000+0  22432-3 0  9992',
        'line2':
            '2 25544  51.6324  52.4887 0007884 189.2977 170.7866 15.48633802556952',
      };

      // act - create a Satellite object from the JSON
      final satellite = Satellite.fromJson(json);

      // assert - verify the values were parsed correctly
      expect(satellite.satelliteId, 25544);
      expect(satellite.name, 'ISS (ZARYA)');
      expect(satellite.line1, isNotEmpty);
      expect(satellite.line2, isNotEmpty);
    });

    // TEST 2 - verify inclination is parsed correctly from TLE line 2
    test('inclination getter returns correct value from TLE line 2', () {
      final json = {
        'satelliteId': 25544,
        'name': 'ISS (ZARYA)',
        'date': '2026-03-13T16:59:24+00:00',
        'line1':
            '1 25544U 98067A   26072.70791847  .00011780  00000+0  22432-3 0  9992',
        'line2':
            '2 25544  51.6324  52.4887 0007884 189.2977 170.7866 15.48633802556952',
      };

      final satellite = Satellite.fromJson(json);

      // inclination should be 51.6324 degrees for ISS
      expect(satellite.inclination, equals(51.6324));
    });
  });
}
