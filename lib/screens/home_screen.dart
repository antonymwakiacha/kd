// // 

// import 'package:flutter/material.dart';
// import 'package:kenyandictionaryapp/models/word.dart';
// import 'package:kenyandictionaryapp/models/idiom.dart';
// import 'package:kenyandictionaryapp/services/cache_service.dart';
// //import 'package:kenyandictionaryapp/utils/cache_service.dart';
// import 'package:kenyandictionaryapp/utils/supabase_config.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Word? wordOfTheDay;
//   Idiom? idiomOfTheDay;
//   String currentDate = '';

//   @override
//   void initState() {
//     super.initState();
//     _setWordAndIdiomOfTheDay();
//   }

//   Future<void> _setWordAndIdiomOfTheDay() async {
//     final now = DateTime.now();

//     // Format date
//     final monthNames = [
//       'January', 'February', 'March', 'April', 'May', 'June',
//       'July', 'August', 'September', 'October', 'November', 'December'
//     ];
//     currentDate = '${monthNames[now.month - 1]} ${now.day}, ${now.year}';

//     // Try to load from cache first
//     final cachedWords = CacheService.getCachedWords();
//     final cachedIdioms = CacheService.getCachedIdioms();

//     if (cachedWords.isNotEmpty) {
//       int wordIndex = now.difference(DateTime(now.year, 1, 1)).inDays % cachedWords.length;
//       wordOfTheDay = cachedWords[wordIndex];
//     }

//     if (cachedIdioms.isNotEmpty) {
//       int idiomIndex = now.difference(DateTime(now.year, 1, 1)).inDays % cachedIdioms.length;
//       idiomOfTheDay = cachedIdioms[idiomIndex];
//     }

//     setState(() {}); // show cached data immediately

//     // Fetch fresh data from Supabase in background
//     try {
//       final wordsCount = await SupabaseConfig.client.from('words').select('id').count(CountOption.exact);
//       final idiomsCount = await SupabaseConfig.client.from('idioms').select('id').count(CountOption.exact);

//       int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;

//       int wordIndex = dayOfYear % (wordsCount.count ?? 1);
//       int idiomIndex = dayOfYear % (idiomsCount.count ?? 1);

//       final wordResponse = await SupabaseConfig.client.from('words').select().range(wordIndex, wordIndex).single();
//       final idiomResponse = await SupabaseConfig.client.from('idioms').select().range(idiomIndex, idiomIndex).single();

//       wordOfTheDay = Word.fromJson(wordResponse);
//       idiomOfTheDay = Idiom.fromJson(idiomResponse);

//       // Cache fresh data
//       await CacheService.saveWord(wordOfTheDay!);
//       await CacheService.saveIdiom(idiomOfTheDay!);

//       setState(() {}); // refresh UI
//     } catch (e) {
//       print('Error fetching daily content: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFCF9E8),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: screenHeight * 0.1),

//             /// Logo
//             Container(
//               width: screenWidth * 0.5,
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               child: Image.asset("lib/images/logoc.jpg"),
//             ),

//             const SizedBox(height: 20),

//             /// Explore/Search button
//             GestureDetector(
//               onTap: () => Navigator.pushNamed(context, '/dictionary'),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: screenWidth * 0.25),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Text(
//                   "Explore/Search",
//                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 40),

//             /// Horizontal scroll cards
//             SizedBox(
//               height: screenHeight * 0.4,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 children: [
//                   // Idiom of the Day
//                   _buildCard(
//                     title: 'IDIOM OF THE DAY',
//                     phrase: idiomOfTheDay?.phrase ?? 'Loading...',
//                     meaning: idiomOfTheDay?.meaning ?? 'No idiom available today',
//                   ),

//                   // Word of the Day
//                   _buildCard(
//                     title: 'WORD OF THE DAY',
//                     phrase: wordOfTheDay?.name ?? 'Loading...',
//                     meaning: wordOfTheDay?.meaning ?? 'No word available today',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCard({required String title, required String phrase, required String meaning}) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.7,
//       margin: const EdgeInsets.only(right: 20),
//       child: Column(
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               color: Colors.black,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text(
//                       phrase,
//                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       meaning,
//                       style: const TextStyle(color: Colors.white, fontSize: 14),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             color: Colors.white,
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//             child: Column(
//               children: [
//                 Text(title, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//                 const SizedBox(height: 5),
//                 Text(currentDate, textAlign: TextAlign.center),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';
import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/utils/supabase_config.dart';
import 'package:kenyandictionaryapp/services/cache_service.dart';

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
      // Attempt to fetch from Supabase first
      final wordsCount = await SupabaseConfig.client
          .from('words')
          .select('id')
          .count();
      final idiomsCount = await SupabaseConfig.client
          .from('idioms')
          .select('id')
          .count();

      int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
      int wordIndex = dayOfYear % (wordsCount.count ?? 1);
      int idiomIndex = dayOfYear % (idiomsCount.count ?? 1);

      final wordResponse = await SupabaseConfig.client
          .from('words')
          .select()
          .range(wordIndex, wordIndex)
          .single();

      final idiomResponse = await SupabaseConfig.client
          .from('idioms')
          .select()
          .range(idiomIndex, idiomIndex)
          .single();

      setState(() {
        wordOfTheDay = Word.fromJson(wordResponse);
        idiomOfTheDay = Idiom.fromJson(idiomResponse);
      });

      // Cache the fetched data
      CacheService.cacheWords([wordOfTheDay!]);
      CacheService.cacheIdioms([idiomOfTheDay!]);
    } catch (e) {
      // If Supabase fetch fails (offline), fallback to Hive cache
      final cachedWords = CacheService.getCachedWords();
      final cachedIdioms = CacheService.getCachedIdioms();

      if (cachedWords.isNotEmpty) {
        int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
        wordOfTheDay = cachedWords[dayOfYear % cachedWords.length];
      }

      if (cachedIdioms.isNotEmpty) {
        int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
        idiomOfTheDay = cachedIdioms[dayOfYear % cachedIdioms.length];
      }

      setState(() {}); // Refresh UI
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
              width: screenWidth * 0.5,
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
                  horizontal: screenWidth * 0.25,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Explore/Search",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'sans-serif',
                  ),
                  textAlign: TextAlign.center,
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
                  _buildCard(
                    phrase: idiomOfTheDay?.phrase ?? 'Loading...',
                    meaning: idiomOfTheDay?.meaning ?? 'No idiom available today',
                    title: 'IDIOM OF THE DAY',
                  ),

                  /// Word of the Day Card
                  _buildCard(
                    phrase: wordOfTheDay?.name ?? 'Loading...',
                    meaning: wordOfTheDay?.meaning ?? 'No word available today',
                    title: 'WORD OF THE DAY',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String phrase, required String meaning, required String title}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.7,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: Colors.black,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      phrase,
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
                      meaning,
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
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(currentDate, textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
