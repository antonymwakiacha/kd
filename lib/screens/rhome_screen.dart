import 'package:flutter/material.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';
import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Word? wordOfTheDay;
  Idiom? idiomOfTheDay;
  String currentDate = '';
  bool isLoading = true;
  String? errorMessage;

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
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Fetch words and idioms from backend
      final words = await ApiService.fetchWords();
      final idioms = await ApiService.fetchIdioms();

      if (words.isEmpty || idioms.isEmpty) {
        setState(() {
          errorMessage = 'No data available';
        });
        return;
      }

      // Pick a "daily" word & idiom based on day of year
      int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
      final wordIndex = dayOfYear % words.length;
      final idiomIndex = dayOfYear % idioms.length;

      setState(() {
        wordOfTheDay = words[wordIndex];
        idiomOfTheDay = idioms[idiomIndex];
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching daily content';
        debugPrint('Error fetching daily content: $e');
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(252, 252, 249, 232),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color:Colors.black))
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
                  child: Column(
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
                            _buildDailyCard(
                              title: 'IDIOM OF THE DAY',
                              content: idiomOfTheDay?.phrase ?? 'No idiom available',
                              meaning: idiomOfTheDay?.meaning ?? '',
                              date: currentDate,
                              screenWidth: screenWidth,
                            ),

                            /// Word of the Day Card
                            _buildDailyCard(
                              title: 'WORD OF THE DAY',
                              content: wordOfTheDay?.name ?? 'No word available',
                              meaning: wordOfTheDay?.meaning ?? '',
                              date: currentDate,
                              screenWidth: screenWidth,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildDailyCard({
    required String title,
    required String content,
    required String meaning,
    required String date,
    required double screenWidth,
  }) {
    return Container(
      width: screenWidth * 0.7,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
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
                      content,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      meaning,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(date, textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
