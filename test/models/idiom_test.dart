import 'package:flutter_test/flutter_test.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';

void main() {
  // Group all tests related to the Idiom model
  group('Idiom Model Tests', () {

    // Test the constructor sets all fields correctly
    test('Idiom constructor sets all fields correctly', () {
      // Create an Idiom object with all fields specified
      final idiom = Idiom(
        id: 1,
        phrase: 'Break the ice',
        meaning: 'To initiate conversation in a social setting',
        isBookmarked: true,
      );

      // Verify each field is correctly assigned
      expect(idiom.id, 1);
      expect(idiom.phrase, 'Break the ice');
      expect(idiom.meaning, contains('initiate conversation'));
      expect(idiom.isBookmarked, true);
    });

    // Test that isBookmarked defaults to false when not specified
    test('Idiom default isBookmarked is false', () {
      // Create an Idiom object without specifying isBookmarked
      final idiom = Idiom(
        id: 2,
        phrase: 'Spill the beans',
        meaning: 'To reveal a secret',
      );

      // By default, isBookmarked should be false
      expect(idiom.isBookmarked, false);
    });

    // Test that Idiom.fromJson parses JSON correctly
    test('Idiom.fromJson creates Idiom correctly', () {
      // JSON input with all fields including is_bookmarked
      final json = {
        'id': 3,
        'phrase': 'Hit the sack',
        'meaning': 'Go to sleep',
        'is_bookmarked': true,
      };

      // Parse JSON into Idiom object
      final idiom = Idiom.fromJson(json);

      // Verify all fields are parsed correctly
      expect(idiom.id, 3);
      expect(idiom.phrase, 'Hit the sack');
      expect(idiom.meaning, 'Go to sleep');
      expect(idiom.isBookmarked, true);
    });

    // Test that fromJson defaults isBookmarked to false if missing
    test('Idiom.fromJson defaults isBookmarked to false if missing', () {
      // JSON input missing is_bookmarked field
      final json = {
        'id': 4,
        'phrase': 'Bite the bullet',
        'meaning': 'To endure a painful situation',
      };

      // Parse JSON into Idiom object
      final idiom = Idiom.fromJson(json);

      // isBookmarked should default to false
      expect(idiom.isBookmarked, false);
    });

    // Test that toJson outputs the correct map
    test('Idiom.toJson outputs correct map', () {
      // Create an Idiom object
      final idiom = Idiom(
        id: 5,
        phrase: 'Let the cat out of the bag',
        meaning: 'Reveal a secret',
        isBookmarked: true,
      );

      // Convert Idiom object to JSON
      final json = idiom.toJson();

      // Verify the JSON map has all correct key-value pairs
      expect(json['id'], 5);
      expect(json['phrase'], 'Let the cat out of the bag');
      expect(json['meaning'], 'Reveal a secret');
      expect(json['is_bookmarked'], true);
    });

    // Test toggling the isBookmarked property
    test('Bookmark toggle behavior works', () {
      // Create an Idiom object with default isBookmarked (false)
      final idiom = Idiom(
        id: 6,
        phrase: 'Kick the bucket',
        meaning: 'To die',
      );

      // Verify initial state is false
      expect(idiom.isBookmarked, false);

      // Change isBookmarked to true
      idiom.isBookmarked = true;

      // Verify the value is updated
      expect(idiom.isBookmarked, true);
    });

  });
}
