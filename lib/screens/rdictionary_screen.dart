import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kenyandictionaryapp/components/word_tile.dart';
import 'package:kenyandictionaryapp/components/idiom_tile.dart';
import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';
import 'package:kenyandictionaryapp/services/api_service.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  List<Word> words = [];
  List<Idiom> idioms = [];
  List<Word> filteredWords = [];
  List<Idiom> filteredIdioms = [];

  bool isSearching = false;
  bool showBookmarksOnly = false;
  String searchQuery = '';
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();

      // Fetch words and idioms via ApiService
      final wordsData = await ApiService.fetchWords();
      final idiomsData = await ApiService.fetchIdioms();

      // Initialize bookmarks from SharedPreferences
      for (var word in wordsData) {
        word.isBookmarked = prefs.getBool('word_${word.id}') ?? false;
      }
      for (var idiom in idiomsData) {
        idiom.isBookmarked = prefs.getBool('idiom_${idiom.id}') ?? false;
      }

      // Sort alphabetically
      wordsData.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      idiomsData.sort((a, b) => a.phrase.toLowerCase().compareTo(b.phrase.toLowerCase()));

      setState(() {
        words = wordsData;
        idioms = idiomsData;
        filteredWords = List.from(words);
        filteredIdioms = List.from(idioms);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data';
        isLoading = false;
      });
      debugPrint('ApiService fetch error: $e');
    }
  }

  void _filterItems(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredWords = List.from(words);
        filteredIdioms = List.from(idioms);
      } else {
        filteredWords = words
            .where((w) => '${w.name} ${w.meaning}'.toLowerCase().contains(query.toLowerCase()))
            .toList();
        filteredIdioms = idioms
            .where((i) => '${i.phrase} ${i.meaning}'.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _toggleWordBookmark(Word word) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      word.isBookmarked = !word.isBookmarked;
      prefs.setBool('word_${word.id}', word.isBookmarked);
    });
  }

  Future<void> _toggleIdiomBookmark(Idiom idiom) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idiom.isBookmarked = !idiom.isBookmarked;
      prefs.setBool('idiom_${idiom.id}', idiom.isBookmarked);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: const Color.fromARGB(252, 252, 249, 232),
        body: Center(
          child: CircularProgressIndicator(color:Colors.black)
          ),
          );
    }

    if (errorMessage != null) {
      return Scaffold(body: Center(child: Text(errorMessage!)));
    }

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
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
          actions: [
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search, color: Colors.white),
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
            _buildListView(displayedWords, (word) => WordTile(word: word, onBookmarkToggle: () => _toggleWordBookmark(word))),
            _buildListView(displayedIdioms, (idiom) => IdiomTile(idiom: idiom, onBookmarkToggle: () => _toggleIdiomBookmark(idiom))),
            _buildBookmarksTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildListView<T>(List<T> items, Widget Function(T) itemBuilder) {
    if (items.isEmpty && searchQuery.isNotEmpty) {
      return Center(child: Text("No results found for '$searchQuery'"));
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(items[index]),
    );
  }

  Widget _buildBookmarksTab() {
    final bookmarkedWords = words.where((w) => w.isBookmarked).toList();
    final bookmarkedIdioms = idioms.where((i) => i.isBookmarked).toList();

    if (bookmarkedWords.isEmpty && bookmarkedIdioms.isEmpty) {
      return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("No bookmarks yet")));
    }

    return ListView(
      children: [
        ...bookmarkedWords.map((w) => WordTile(word: w, onBookmarkToggle: () => _toggleWordBookmark(w))),
        ...bookmarkedIdioms.map((i) => IdiomTile(idiom: i, onBookmarkToggle: () => _toggleIdiomBookmark(i))),
      ],
    );
  }
}
