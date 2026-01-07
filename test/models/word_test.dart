import 'package:flutter_test/flutter_test.dart';
import 'package:kenyandictionaryapp/models/word.dart';

void main() {
  // Group all tests related to the Word model
  group('Word Model Tests', () {

    // Test the constructor sets all fields correctly
    test('Word constructor sets all fields correctly', () {
      // Create a Word object with all fields specified
      final word = Word(
        id: 1,
        name: 'SHIF',
        type: 'noun',
        meaning: 'A kind of greed mentioned in the Bible',
        isBookmarked: true,
      );

      // Verify each field is correctly assigned
      expect(word.id, 1);
      expect(word.name, 'SHIF');
      expect(word.type, 'noun');
      expect(word.meaning, contains('greed'));
      expect(word.isBookmarked, true);
    });

    // Test that isBookmarked defaults to false when not specified
    test('Word default isBookmarked is false', () {
      // Create a Word object without specifying isBookmarked
      final word = Word(
        id: 2,
        name: 'KIF',
        meaning: 'Another meaning here',
      );

      // By default, isBookmarked should be false
      expect(word.isBookmarked, false);
    });

    // Test that Word.fromJson parses JSON correctly
    test('Word.fromJson creates Word correctly', () {
      // JSON input with all fields including is_bookmarked
      final json = {
        'id': 3,
        'name': 'LIF',
        'type': 'verb',
        'meaning': 'Test meaning',
        'is_bookmarked': true,
      };

      // Parse JSON into Word object
      final word = Word.fromJson(json);

      // Verify all fields are parsed correctly
      expect(word.id, 3);
      expect(word.name, 'LIF');
      expect(word.type, 'verb');
      expect(word.meaning, 'Test meaning');
      expect(word.isBookmarked, true);
    });

    // Test that fromJson defaults isBookmarked to false if missing
    test('Word.fromJson defaults isBookmarked to false if missing', () {
      // JSON input missing is_bookmarked field
      final json = {
        'id': 4,
        'name': 'MIF',
        'type': 'adjective',
        'meaning': 'Another test meaning',
      };

      // Parse JSON into Word object
      final word = Word.fromJson(json);

      // isBookmarked should default to false
      expect(word.isBookmarked, false);
    });

    // Test that toJson outputs the correct map
    test('Word.toJson outputs correct map', () {
      // Create a Word object
      final word = Word(
        id: 5,
        name: 'NIF',
        type: 'noun',
        meaning: 'Meaning for NIF',
        isBookmarked: true,
      );

      // Convert Word object to JSON
      final json = word.toJson();

      // Verify the JSON map has all correct key-value pairs
      expect(json['id'], 5);
      expect(json['name'], 'NIF');
      expect(json['type'], 'noun');
      expect(json['meaning'], 'Meaning for NIF');
      expect(json['is_bookmarked'], true);
    });

    // Test toggling the isBookmarked property
    test('Bookmark toggle behavior works', () {
      // Create a Word object with default isBookmarked (false)
      final word = Word(
        id: 6,
        name: 'PIF',
        meaning: 'Test toggle',
      );

      // Verify initial state is false
      expect(word.isBookmarked, false);

      // Change isBookmarked to true
      word.isBookmarked = true;

      // Verify the value is updated
      expect(word.isBookmarked, true);
    });

  });
}
