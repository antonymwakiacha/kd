// 

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';

// 
class ApiService {
  static const String _baseUrl = 'https://supabaseproxybackend-production.up.railway.app/api';
  static const String _wordsEndpoint = '$_baseUrl/words/';
  static const String _idiomsEndpoint = '$_baseUrl/idioms/';

  /// Fetch all words
  static Future<List<Word>> fetchWords() async {
    try {
      final response = await http.get(Uri.parse(_wordsEndpoint));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List<dynamic> dataList = jsonMap['data']; // <-- extract 'data' list
        return dataList.map((e) => Word.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load words (status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error fetching words: $e');
    }
  }

  /// Fetch all idioms
  static Future<List<Idiom>> fetchIdioms() async {
    try {
      final response = await http.get(Uri.parse(_idiomsEndpoint));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List<dynamic> dataList = jsonMap['data']; // <-- same fix
        return dataList.map((e) => Idiom.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load idioms (status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error fetching idioms: $e');
    }
  }
}
