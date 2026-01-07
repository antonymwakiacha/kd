import 'package:flutter/material.dart';
import 'package:kenyandictionaryapp/utils/supabase_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kenyandictionaryapp/components/word_tile.dart';
import 'package:kenyandictionaryapp/components/idiom_tile.dart';
import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DictionaryScreen extends StatefulWidget {
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
    filteredWords = words;
    filteredIdioms = idioms;
    _loadBookmarks();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Fetch words and idioms from Supabase
      final wordsResponse = await SupabaseConfig.client.from('words').select();
      final idiomsResponse = await SupabaseConfig.client.from('idioms').select();

      setState(() {
        // Convert JSON to objects
        words = wordsResponse.map((json) => Word.fromJson(json)).toList();
        idioms = idiomsResponse.map((json) => Idiom.fromJson(json)).toList();

        // Sort alphabetically
        words.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        idioms.sort((a, b) => a.phrase.toLowerCase().compareTo(b.phrase.toLowerCase()));

        // Initialize filtered lists
        filteredWords = List.from(words);
        filteredIdioms = List.from(idioms);
      });
    } catch (e) {
      print('Error fetching data: $e');
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
            .where((word) =>
                word.name.toLowerCase().contains(query.toLowerCase()) ||
                word.meaning.toLowerCase().contains(query.toLowerCase()))
            .toList();

        filteredIdioms = idioms
            .where((idiom) =>
                idiom.phrase.toLowerCase().contains(query.toLowerCase()) ||
                idiom.meaning.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      for (var word in words) {
        word.isBookmarked = prefs.getBool('word_${word.name}') ?? false;
      }
      for (var idiom in idioms) {
        idiom.isBookmarked = prefs.getBool('idiom_${idiom.phrase}') ?? false;
      }
    });
  }

  Future<void> _toggleWordBookmark(Word word) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      word.isBookmarked = !word.isBookmarked;
      prefs.setBool('word_${word.name}', word.isBookmarked);
    });

    try {
      await SupabaseConfig.client
          .from('words')
          .update({'is_bookmarked': word.isBookmarked})
          .eq('id', word.id);
    } catch (e) {
      print('Error updating bookmark: $e');
    }
  }

  Future<void> _toggleIdiomBookmark(Idiom idiom) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      idiom.isBookmarked = !idiom.isBookmarked;
      prefs.setBool('idiom_${idiom.id}', idiom.isBookmarked);
    });

    try {
      await SupabaseConfig.client
          .from('idioms')
          .update({'is_bookmarked': idiom.isBookmarked})
          .eq('id', idiom.id);
    } catch (e) {
      print('Error updating bookmark: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Display lists based on bookmarks filter
    List<Word> displayedWords = showBookmarksOnly
        ? filteredWords.where((w) => w.isBookmarked).toList()
        : filteredWords;
    List<Idiom> displayedIdioms = showBookmarksOnly
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
                  decoration: InputDecoration(
                    hintText: 'Search words or idioms...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  onChanged: _filterItems,
                )
              : Text(
                  "Kenyan Dictionary",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
          actions: [
            if (isSearching)
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    searchQuery = '';
                    filteredWords = List.from(words);
                    filteredIdioms = List.from(idioms);
                  });
                },
              )
            else
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                },
              ),
            IconButton(
              icon: Icon(
                showBookmarksOnly ? Icons.bookmark : Icons.bookmark_border,
                color: Colors.amberAccent,
              ),
              onPressed: () {
                setState(() {
                  showBookmarksOnly = !showBookmarksOnly;
                });
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.amberAccent,
            labelColor: Colors.amberAccent,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Words (${displayedWords.length})"),
              Tab(text: "Idioms (${displayedIdioms.length})"),
              Tab(icon: Icon(Icons.bookmark)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Words Tab
            displayedWords.isEmpty && searchQuery.isNotEmpty
                ? Center(child: Text("No words found for '$searchQuery'"))
                : ListView.builder(
                    itemCount: displayedWords.length,
                    itemBuilder: (context, index) {
                      return WordTile(
                        word: displayedWords[index],
                        onBookmarkToggle: () => _toggleWordBookmark(displayedWords[index]),
                      );
                    },
                  ),

            // Idioms Tab
            displayedIdioms.isEmpty && searchQuery.isNotEmpty
                ? Center(child: Text("No idioms found for '$searchQuery'"))
                : ListView.builder(
                    itemCount: displayedIdioms.length,
                    itemBuilder: (context, index) {
                      return IdiomTile(
                        idiom: displayedIdioms[index],
                        onBookmarkToggle: () => _toggleIdiomBookmark(displayedIdioms[index]),
                      );
                    },
                  ),

            // Bookmarks Tab
            ListView(
              children: [
                ...words.where((w) => w.isBookmarked).map(
                      (w) => WordTile(
                        word: w,
                        onBookmarkToggle: () => _toggleWordBookmark(w),
                      ),
                    ),
                ...idioms.where((i) => i.isBookmarked).map(
                      (i) => IdiomTile(
                        idiom: i,
                        onBookmarkToggle: () => _toggleIdiomBookmark(i),
                      ),
                    ),
                if (words.where((w) => w.isBookmarked).isEmpty &&
                    idioms.where((i) => i.isBookmarked).isEmpty)
                  Center(
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
