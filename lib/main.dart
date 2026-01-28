// // 

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import 'package:kenyandictionaryapp/screens/landing_screen.dart';
// import 'package:kenyandictionaryapp/screens/home_screen.dart';
// import 'package:kenyandictionaryapp/screens/dictionary_screen.dart';
// import 'package:kenyandictionaryapp/screens/rhome_screen.dart' hide HomeScreen;

// import 'package:kenyandictionaryapp/utils/supabase_config.dart';
// import 'package:kenyandictionaryapp/env/env.dart';

// import 'package:kenyandictionaryapp/models/word.dart';
// import 'package:kenyandictionaryapp/models/idiom.dart';
// import 'package:kenyandictionaryapp/services/cache_service.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   /* ----------------------------- */
//   /* 1. Initialize Hive            */
//   /* ----------------------------- */
//   await Hive.initFlutter();

//   // Register adapters (safe to call multiple times)
//   if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(WordAdapter());
//   if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(IdiomAdapter());

//   // Open Hive boxes using CacheService
//   await CacheService.openBoxes();

//   /* ----------------------------- */
//   /* 2. Load Envied secrets        */
//   /* ----------------------------- */
//   final supabaseUrl = Env.supabaseUrl;
//   final supabaseAnonKey = Env.supabaseAnonKey;

//   if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
//     throw Exception('Supabase credentials missing in Envied configuration.');
//   }

//   /* ----------------------------- */
//   /* 3. Initialize Supabase        */
//   /* ----------------------------- */
//   await SupabaseConfig.initialize(
//     supabaseUrl: supabaseUrl,
//     supabaseAnonKey: supabaseAnonKey,
//   );

//   /* ----------------------------- */
//   /* 4. Run app                    */
//   /* ----------------------------- */
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         '/home_screen': (context) => const HomeScreen(),
//         '/dictionary': (context) => DictionaryScreen(),
//       },
//       home: const LandingPage(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kenyandictionaryapp/screens/landing_screen.dart';
import 'package:kenyandictionaryapp/screens/home_screen.dart';
import 'package:kenyandictionaryapp/screens/dictionary_screen.dart';

import 'package:kenyandictionaryapp/utils/supabase_config.dart';
import 'package:kenyandictionaryapp/env/env.dart';

import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';
import 'package:kenyandictionaryapp/services/cache_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// -----------------------------
  /// 1. Initialize Hive
  /// -----------------------------
  await Hive.initFlutter();

  // Register adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(WordAdapter());
  }

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(IdiomAdapter());
  }

  // Open all boxes via CacheService
  await CacheService.openBoxes();

  /// -----------------------------
  /// 2. Load Envied secrets
  /// -----------------------------
  final supabaseUrl = Env.supabaseUrl;
  final supabaseAnonKey = Env.supabaseAnonKey;

  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    throw Exception('Supabase credentials missing in Envied configuration.');
  }

  /// -----------------------------
  /// 3. Initialize Supabase
  /// -----------------------------
  await SupabaseConfig.initialize(
    supabaseUrl: supabaseUrl,
    supabaseAnonKey: supabaseAnonKey,
  );

  /// -----------------------------
  /// 4. Run the app
  /// -----------------------------
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home_screen': (context) => const HomeScreen(),
        '/dictionary': (context) => const DictionaryScreen(),
      },
      home: const LandingPage(),
    );
  }
}
