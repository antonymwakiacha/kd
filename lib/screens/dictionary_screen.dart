// // //

// // import 'package:flutter/material.dart';
// // import 'package:kenyandictionaryapp/models/word.dart';
// // import 'package:kenyandictionaryapp/models/idiom.dart';
// // import 'package:kenyandictionaryapp/components/word_tile.dart';
// // import 'package:kenyandictionaryapp/components/idiom_tile.dart';
// // import 'package:kenyandictionaryapp/services/cache_service.dart';
// // //import 'package:kenyandictionaryapp/utils/cache_service.dart';

// // class DictionaryScreen extends StatefulWidget {
// //   const DictionaryScreen({super.key});

// //   @override
// //   State<DictionaryScreen> createState() => _DictionaryScreenState();
// // }

// // class _DictionaryScreenState extends State<DictionaryScreen> {
// //   List<Word> words = [];
// //   List<Idiom> idioms = [];
// //   bool showBookmarksOnly = false;
// //   bool isSearching = false;
// //   String searchQuery = '';
// //   late List<Word> filteredWords;
// //   late List<Idiom> filteredIdioms;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadData();
// //   }

// //   void _loadData() {
// //     words = CacheService.getCachedWords();
// //     idioms = CacheService.getCachedIdioms();

// //     words.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
// //     idioms.sort((a, b) => a.phrase.toLowerCase().compareTo(b.phrase.toLowerCase()));

// //     filteredWords = List.from(words);
// //     filteredIdioms = List.from(idioms);
// //     setState(() {});
// //   }

// //   void _filterItems(String query) {
// //     searchQuery = query;
// //     if (query.isEmpty) {
// //       filteredWords = List.from(words);
// //       filteredIdioms = List.from(idioms);
// //     } else {
// //       filteredWords = words
// //           .where((w) => w.name.toLowerCase().contains(query.toLowerCase()) || w.meaning.toLowerCase().contains(query.toLowerCase()))
// //           .toList();
// //       filteredIdioms = idioms
// //           .where((i) => i.phrase.toLowerCase().contains(query.toLowerCase()) || i.meaning.toLowerCase().contains(query.toLowerCase()))
// //           .toList();
// //     }
// //     setState(() {});
// //   }

// //   void _toggleWordBookmark(Word word) async {
// //     await CacheService.toggleWordBookmark(word);
// //     setState(() {});
// //   }

// //   void _toggleIdiomBookmark(Idiom idiom) async {
// //     await CacheService.toggleIdiomBookmark(idiom);
// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     List<Word> displayedWords = showBookmarksOnly ? CacheService.getBookmarkedWords() : filteredWords;
// //     List<Idiom> displayedIdioms = showBookmarksOnly ? CacheService.getBookmarkedIdioms() : filteredIdioms;

// //     return DefaultTabController(
// //       length: 3,
// //       child: Scaffold(
// //         backgroundColor: const Color(0xFFFCF9E8),
// //         appBar: AppBar(
// //           backgroundColor: Colors.black,
// //           title: isSearching
// //               ? TextField(
// //                   autofocus: true,
// //                   decoration: const InputDecoration(
// //                     hintText: 'Search words or idioms...',
// //                     border: InputBorder.none,
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     contentPadding: EdgeInsets.symmetric(horizontal: 12),
// //                   ),
// //                   onChanged: _filterItems,
// //                 )
// //               : const Text("Kenyan Dictionary", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// //           actions: [
// //             IconButton(
// //               icon: Icon(showBookmarksOnly ? Icons.bookmark : Icons.bookmark_border, color: Colors.amberAccent),
// //               onPressed: () => setState(() => showBookmarksOnly = !showBookmarksOnly),
// //             ),
// //             IconButton(
// //               icon: Icon(isSearching ? Icons.close : Icons.search, color: Colors.white),
// //               onPressed: () {
// //                 setState(() {
// //                   if (isSearching) {
// //                     searchQuery = '';
// //                     filteredWords = List.from(words);
// //                     filteredIdioms = List.from(idioms);
// //                   }
// //                   isSearching = !isSearching;
// //                 });
// //               },
// //             ),
// //           ],
// //           bottom: TabBar(
// //             indicatorColor: Colors.amberAccent,
// //             labelColor: Colors.amberAccent,
// //             unselectedLabelColor: Colors.white70,
// //             tabs: [
// //               Tab(text: "Words (${displayedWords.length})"),
// //               Tab(text: "Idioms (${displayedIdioms.length})"),
// //               const Tab(icon: Icon(Icons.bookmark)),
// //             ],
// //           ),
// //         ),
// //         body: TabBarView(
// //           children: [
// //             ListView.builder(
// //               itemCount: displayedWords.length,
// //               itemBuilder: (context, index) => WordTile(
// //                 word: displayedWords[index],
// //                 onBookmarkToggle: () => _toggleWordBookmark(displayedWords[index]),
// //               ),
// //             ),
// //             ListView.builder(
// //               itemCount: displayedIdioms.length,
// //               itemBuilder: (context, index) => IdiomTile(
// //                 idiom: displayedIdioms[index],
// //                 onBookmarkToggle: () => _toggleIdiomBookmark(displayedIdioms[index]),
// //               ),
// //             ),
// //             ListView(
// //               children: [
// //                 ...CacheService.getBookmarkedWords().map((w) => WordTile(word: w, onBookmarkToggle: () => _toggleWordBookmark(w))),
// //                 ...CacheService.getBookmarkedIdioms().map((i) => IdiomTile(idiom: i, onBookmarkToggle: () => _toggleIdiomBookmark(i))),
// //                 if (CacheService.getBookmarkedWords().isEmpty && CacheService.getBookmarkedIdioms().isEmpty)
// //                   const Center(
// //                     child: Padding(
// //                       padding: EdgeInsets.all(20),
// //                       child: Text("No bookmarks yet"),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:kenyandictionaryapp/models/word.dart';
// import 'package:kenyandictionaryapp/models/idiom.dart';
// import 'package:kenyandictionaryapp/services/cache_service.dart';
// import 'package:kenyandictionaryapp/utils/supabase_config.dart';

// class DictionaryScreen extends StatefulWidget {
//   const DictionaryScreen({super.key});

//   @override
//   State<DictionaryScreen> createState() => _DictionaryScreenState();
// }

// class _DictionaryScreenState extends State<DictionaryScreen> {
//   List<Word> allWords = [];
//   List<Idiom> allIdioms = [];
//   List<Word> displayedWords = [];
//   List<Idiom> displayedIdioms = [];

//   final TextEditingController _searchController = TextEditingController();
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializeDictionary();
//     _searchController.addListener(_onSearchChanged);
//   }

//   /// -----------------------------
//   /// Initialize dictionary screen
//   /// -----------------------------
//   Future<void> _initializeDictionary() async {
//     await CacheService.openBoxes();

//     // Load cached data first
//     final cachedWords = CacheService.getCachedWords();
//     final cachedIdioms = CacheService.getCachedIdioms();

//     setState(() {
//       allWords = cachedWords;
//       allIdioms = cachedIdioms;
//       displayedWords = List.from(allWords);
//       displayedIdioms = List.from(allIdioms);
//       isLoading = false;
//     });

//     // Fetch latest data from Supabase asynchronously
//     _fetchAndCacheData();
//   }

//   /// -----------------------------
//   /// Fetch and cache data from Supabase
//   /// -----------------------------
//   Future<void> _fetchAndCacheData() async {
//     try {
//       final wordsResponse = await SupabaseConfig.client.from('words').select();
//       final idiomsResponse = await SupabaseConfig.client.from('idioms').select();

//       final fetchedWords = wordsResponse.map((json) => Word.fromJson(json)).toList();
//       final fetchedIdioms = idiomsResponse.map((json) => Idiom.fromJson(json)).toList();

//       // Cache all data
//       await CacheService.cacheWords(fetchedWords);
//       await CacheService.cacheIdioms(fetchedIdioms);

//       setState(() {
//         allWords = fetchedWords;
//         allIdioms = fetchedIdioms;
//         _applySearchFilter(_searchController.text);
//       });
//     } catch (e) {
//       print('Error fetching dictionary data: $e');
//     }
//   }

//   /// -----------------------------
//   /// Search filter
//   /// -----------------------------
//   void _onSearchChanged() {
//     _applySearchFilter(_searchController.text);
//   }

//   void _applySearchFilter(String query) {
//     final lowerQuery = query.toLowerCase();

//     setState(() {
//       displayedWords = allWords
//           .where((word) => word.name.toLowerCase().contains(lowerQuery))
//           .toList();
//       displayedIdioms = allIdioms
//           .where((idiom) => idiom.phrase.toLowerCase().contains(lowerQuery))
//           .toList();
//     });
//   }

//   /// -----------------------------
//   /// Toggle bookmark
//   /// -----------------------------
//   Future<void> _toggleWordBookmark(Word word) async {
//     setState(() {
//       word.isBookmarked = !word.isBookmarked;
//     });
//     await CacheService.saveWord(word);
//   }

//   Future<void> _toggleIdiomBookmark(Idiom idiom) async {
//     setState(() {
//       idiom.isBookmarked = !idiom.isBookmarked;
//     });
//     await CacheService.saveIdiom(idiom);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dictionary'),
//         backgroundColor: Colors.black,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 // -----------------------------
//                 // Search Field
//                 // -----------------------------
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: InputDecoration(
//                       hintText: 'Search words or idioms...',
//                       prefixIcon: const Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // -----------------------------
//                 // Words List
//                 // -----------------------------
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     children: [
//                       if (displayedWords.isNotEmpty) ...[
//                         const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Text('Words',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                         ),
//                         ...displayedWords.map(
//                           (word) => Card(
//                             child: ListTile(
//                               title: Text(word.name),
//                               subtitle: Text(word.meaning),
//                               trailing: IconButton(
//                                 icon: Icon(
//                                   word.isBookmarked
//                                       ? Icons.bookmark
//                                       : Icons.bookmark_border,
//                                   color: word.isBookmarked
//                                       ? Colors.blueAccent
//                                       : Colors.grey,
//                                 ),
//                                 onPressed: () => _toggleWordBookmark(word),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],

//                       // -----------------------------
//                       // Idioms List
//                       // -----------------------------
//                       if (displayedIdioms.isNotEmpty) ...[
//                         const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Text('Idioms',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                         ),
//                         ...displayedIdioms.map(
//                           (idiom) => Card(
//                             child: ListTile(
//                               title: Text(idiom.phrase),
//                               subtitle: Text(idiom.meaning),
//                               trailing: IconButton(
//                                 icon: Icon(
//                                   idiom.isBookmarked
//                                       ? Icons.bookmark
//                                       : Icons.bookmark_border,
//                                   color: idiom.isBookmarked
//                                       ? Colors.blueAccent
//                                       : Colors.grey,
//                                 ),
//                                 onPressed: () => _toggleIdiomBookmark(idiom),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],

//                       if (displayedWords.isEmpty && displayedIdioms.isEmpty)
//                         const Center(
//                             child: Padding(
//                           padding: EdgeInsets.all(20.0),
//                           child: Text('No results found'),
//                         )),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';
import 'package:kenyandictionaryapp/components/word_tile.dart';
import 'package:kenyandictionaryapp/components/idiom_tile.dart';
import 'package:kenyandictionaryapp/services/cache_service.dart';
//import 'package:kenyandictionaryapp/utils/cache_service.dart';
import 'package:kenyandictionaryapp/utils/supabase_config.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  List<Word> words = [];
  List<Idiom> idioms = [];
  bool showBookmarksOnly = false;
  bool isSearching = false;
  String searchQuery = '';
  late List<Word> filteredWords;
  late List<Idiom> filteredIdioms;

  @override
  void initState() {
    super.initState();
    filteredWords = [];
    filteredIdioms = [];
    _loadCachedData();
    _loadSupabaseData();
  }

  void _loadCachedData() {
    words = CacheService.getCachedWords();
    idioms = CacheService.getCachedIdioms();
    filteredWords = List.from(words);
    filteredIdioms = List.from(idioms);
    setState(() {});
  }

  Future<void> _loadSupabaseData() async {
    try {
      final wordsResponse = await SupabaseConfig.client.from('words').select();
      final idiomsResponse = await SupabaseConfig.client
          .from('idioms')
          .select();

      final freshWords = wordsResponse
          .map((json) => Word.fromJson(json))
          .toList();
      final freshIdioms = idiomsResponse
          .map((json) => Idiom.fromJson(json))
          .toList();

      // Sort alphabetically
      freshWords.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
      freshIdioms.sort(
        (a, b) => a.phrase.toLowerCase().compareTo(b.phrase.toLowerCase()),
      );

      // Cache fresh data
      await CacheService.cacheWords(freshWords);
      await CacheService.cacheIdioms(freshIdioms);

      setState(() {
        words = freshWords;
        idioms = freshIdioms;
        filteredWords = List.from(words);
        filteredIdioms = List.from(idioms);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _filterItems(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredWords = List.from(words);
      filteredIdioms = List.from(idioms);
    } else {
      filteredWords = words
          .where(
            (w) =>
                w.name.toLowerCase().contains(query.toLowerCase()) ||
                w.meaning.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      filteredIdioms = idioms
          .where(
            (i) =>
                i.phrase.toLowerCase().contains(query.toLowerCase()) ||
                i.meaning.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final displayedWords = showBookmarksOnly
        ? filteredWords.where((w) => w.isBookmarked).toList()
        : filteredWords;
    final displayedIdioms = showBookmarksOnly
        ? filteredIdioms.where((i) => i.isBookmarked).toList()
        : filteredIdioms;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFFCF9E8),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: isSearching
              ? TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search words or idioms...',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  onChanged: _filterItems,
                )
              : const Text(
                  "Kenyan Dictionary",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          actions: [
            IconButton(
              icon: Icon(
                isSearching ? Icons.close : Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (isSearching) {
                    searchQuery = '';
                    filteredWords = List.from(words);
                    filteredIdioms = List.from(idioms);
                  }
                  isSearching = !isSearching;
                });
              },
            ),
            // IconButton(
            //   icon: Icon(
            //     showBookmarksOnly ? Icons.bookmark : Icons.bookmark_border,
            //     color: Colors.amberAccent,
            //   ),
            //   onPressed: () => setState(() => showBookmarksOnly = !showBookmarksOnly),
            // ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.amberAccent,
            labelColor: Colors.amberAccent,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Words (${displayedWords.length})"),
              Tab(text: "Idioms (${displayedIdioms.length})"),
              const Tab(icon: Icon(Icons.bookmark)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Words
            displayedWords.isEmpty && searchQuery.isNotEmpty
                ? Center(child: Text("No words found for '$searchQuery'"))
                : ListView.builder(
                    itemCount: displayedWords.length,
                    itemBuilder: (context, index) {
                      final word = displayedWords[index];
                      return WordTile(
                        word: word,
                        onBookmarkToggle: () async {
                          word.isBookmarked = !word.isBookmarked;
                          await CacheService.saveWord(word);
                          setState(() {});
                        },
                      );
                    },
                  ),
            // Idioms
            displayedIdioms.isEmpty && searchQuery.isNotEmpty
                ? Center(child: Text("No idioms found for '$searchQuery'"))
                : ListView.builder(
                    itemCount: displayedIdioms.length,
                    itemBuilder: (context, index) {
                      final idiom = displayedIdioms[index];
                      return IdiomTile(
                        idiom: idiom,
                        onBookmarkToggle: () async {
                          idiom.isBookmarked = !idiom.isBookmarked;
                          await CacheService.saveIdiom(idiom);
                          setState(() {});
                        },
                      );
                    },
                  ),
            // Bookmarks
            ListView(
              children: [
                ...words
                    .where((w) => w.isBookmarked)
                    .map(
                      (w) => WordTile(
                        word: w,
                        onBookmarkToggle: () async {
                          w.isBookmarked = !w.isBookmarked;
                          await CacheService.saveWord(w);
                          setState(() {});
                        },
                      ),
                    ),
                ...idioms
                    .where((i) => i.isBookmarked)
                    .map(
                      (i) => IdiomTile(
                        idiom: i,
                        onBookmarkToggle: () async {
                          i.isBookmarked = !i.isBookmarked;
                          await CacheService.saveIdiom(i);
                          setState(() {});
                        },
                      ),
                    ),
                if (words.where((w) => w.isBookmarked).isEmpty &&
                    idioms.where((i) => i.isBookmarked).isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("No bookmarks yet"),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
