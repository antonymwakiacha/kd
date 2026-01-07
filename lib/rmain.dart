import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:kenyandictionaryapp/screens/old_dictionary_screen.dart';
import 'package:kenyandictionaryapp/screens/rdictionary_screen.dart';
//import 'package:kenyandictionaryapp/screens/old_landing_screen.dart';
import 'package:kenyandictionaryapp/screens/rlanding_screen.dart';
import 'package:kenyandictionaryapp/screens/rhome_screen.dart'; // ✅ updated
// import 'package:kenyandictionaryapp/utils/supabase_config.dart'; // ❌ no longer needed

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (still useful if you have API keys or settings)
  await dotenv.load(fileName: ".env");

  // ❌ No need to initialize Supabase anymore
  // await SupabaseConfig.initialize();

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
        '/dictionary': (context) => DictionaryScreen(),
      },
      home: const LandingPage(),
    );
  }
}
