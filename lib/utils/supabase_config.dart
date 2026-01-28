import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static late final SupabaseClient client;
  static late final String url;
  static late final String anonKey;

  /// Initialize Supabase with URL and anon key
  static Future<void> initialize({
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) async {
    url = supabaseUrl;
    anonKey = supabaseAnonKey;

    // Debug prints
    debugPrint('Initializing Supabase with:');
    debugPrint('URL: $url');
    debugPrint('AnonKey length: ${anonKey.length}');

    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      debug: true, // Turn on logging for testing
    );

    client = Supabase.instance.client;
  }
}

