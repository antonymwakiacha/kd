import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';
import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/utils/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

Word? wordOfTheDay;
  Idiom? idiomOfTheDay;
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    _setWordAndIdiomOfTheDay();
  }

  Future<void> _setWordAndIdiomOfTheDay() async {
    final now = DateTime.now();
    
    // Format the date
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    setState(() {
      currentDate = '${monthNames[now.month - 1]} ${now.day}, ${now.year}';
    });
    
    try {
      // Get total count of words and idioms
      final wordsCount = await SupabaseConfig.client
          .from('words')
          .select('id')
          .count(CountOption.exact);
      
      final idiomsCount = await SupabaseConfig.client
          .from('idioms')
          .select('id')
          .count(CountOption.exact);
      
      // Calculate indices based on the day of the year
      int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
      int wordIndex = dayOfYear % (wordsCount.count ?? 1);
      int idiomIndex = dayOfYear % (idiomsCount.count ?? 1);
      
      // Fetch word of the day
      final wordResponse = await SupabaseConfig.client
          .from('words')
          .select()
          .range(wordIndex, wordIndex)
          .single();
      
      // Fetch idiom of the day
      final idiomResponse = await SupabaseConfig.client
          .from('idioms')
          .select()
          .range(idiomIndex, idiomIndex)
          .single();
      
      setState(() {
        wordOfTheDay = Word.fromJson(wordResponse);
        idiomOfTheDay = Idiom.fromJson(idiomResponse);
      });
    } catch (e) {
      print('Error fetching daily content: $e');
    }
  }

@override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Scaffold(
    backgroundColor: const Color.fromARGB(252, 252, 249, 232),
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.1),

          /// Logo
          Container(
            width: screenWidth * 0.5, // 50% of screen width
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset("lib/images/logoc.jpg"),
          ),

          const SizedBox(height: 20),

          /// Explore/Search button
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/dictionary'),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: screenWidth * 0.25, // 25% of screen width
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Explore/Search ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'sans-serif',
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          /// Idiom + Word scrollable cards
          SizedBox(
            height: screenHeight * 0.4,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                /// Idiom of the Day Card
                Container(
                  width: screenWidth * 0.7,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          color: Colors.black,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  idiomOfTheDay?.phrase ?? 'Loading...',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  idiomOfTheDay?.meaning ??
                                      'No idiom available today',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: screenWidth * 0.05,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'IDIOM OF THE DAY',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(currentDate, textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Word of the Day Card
                Container(
                  width: screenWidth * 0.7,
                  margin: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          color: Colors.black,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  wordOfTheDay?.name ?? 'Loading...',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  wordOfTheDay?.meaning ??
                                      'No word available today',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: screenWidth * 0.05,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'WORD OF THE DAY',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(currentDate, textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}



}
