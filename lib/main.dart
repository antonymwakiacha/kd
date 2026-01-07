import 'package:flutter/material.dart';
import 'package:kenyandictionaryapp/components/word_tile.dart';
import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/screens/dictionary_screen.dart';
import 'package:kenyandictionaryapp/screens/landing_screen.dart';
import 'package:kenyandictionaryapp/screens/home_screen.dart';
import 'package:kenyandictionaryapp/screens/list_view.dart';
import 'package:kenyandictionaryapp/utils/supabase_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home_screen': (context) => const HomeScreen(),
        '/dictionary': (context) =>  DictionaryScreen(),
      },
       home: LandingPage(),
      // home: WordTile(
      //   word: Word(name:'SHIF',
      //   type:'noun',
      //   meaning:"This is the kind of greed they talk about in the bible.Sahii payslip inakaa receipt ya supermarket.",
      //   ),
      // ),
      //home: ListViewTest(),
    );
  }
}
