// // import 'package:hive/hive.dart';
// // import 'package:kenyandictionaryapp/models/word.dart';
// // import 'package:kenyandictionaryapp/models/idiom.dart';
// // import 'package:kenyandictionaryapp/utils/supabase_config.dart';

// // class CacheService {
// //   static final Box<Word> _wordsBox = Hive.box<Word>('wordsBox');
// //   static final Box<Idiom> _idiomsBox = Hive.box<Idiom>('idiomsBox');
// //   static final Box _metaBox = Hive.box('metaBox');

// //   /* ----------------------------- */
// //   /* CACHE VALIDATION              */
// //   /* ----------------------------- */

// //   static bool _isSameDay(DateTime a, DateTime b) {
// //     return a.year == b.year && a.month == b.month && a.day == b.day;
// //   }

// //   static bool shouldRefreshToday() {
// //     final lastSync = _metaBox.get('lastSync');

// //     if (lastSync == null) return true;

// //     final lastSyncDate = DateTime.parse(lastSync);
// //     return !_isSameDay(lastSyncDate, DateTime.now());
// //   }

// //   static Future<void> _updateLastSync() async {
// //     await _metaBox.put(
// //       'lastSync',
// //       DateTime.now().toIso8601String(),
// //     );
// //   }

// //   /* ----------------------------- */
// //   /* WORDS                         */
// //   /* ----------------------------- */

// //   static List<Word> getCachedWords() {
// //     return _wordsBox.values.toList();
// //   }

// //   static Future<List<Word>> syncWords() async {
// //     final response = await SupabaseConfig.client
// //         .from('words')
// //         .select();

// //     final words = response
// //         .map<Word>((json) => Word.fromJson(json))
// //         .toList();

// //     await _wordsBox.clear();
// //     await _wordsBox.addAll(words);

// //     await _updateLastSync();
// //     return words;
// //   }

// //   /* ----------------------------- */
// //   /* IDIOMS                        */
// //   /* ----------------------------- */

// //   static List<Idiom> getCachedIdioms() {
// //     return _idiomsBox.values.toList();
// //   }

// //   static Future<List<Idiom>> syncIdioms() async {
// //     final response = await SupabaseConfig.client
// //         .from('idioms')
// //         .select();

// //     final idioms = response
// //         .map<Idiom>((json) => Idiom.fromJson(json))
// //         .toList();

// //     await _idiomsBox.clear();
// //     await _idiomsBox.addAll(idioms);

// //     await _updateLastSync();
// //     return idioms;
// //   }

// //   /* ----------------------------- */
// //   /* FULL SYNC                     */
// //   /* ----------------------------- */

// //   static Future<void> syncAllIfNeeded() async {
// //     if (shouldRefreshToday()) {
// //       await Future.wait([
// //         syncWords(),
// //         syncIdioms(),
// //       ]);
// //     }
// //   }
// // }


// // import 'package:hive/hive.dart';
// // import 'package:kenyandictionaryapp/models/word.dart';
// // import 'package:kenyandictionaryapp/models/idiom.dart';

// // class CacheService {
// //   static const String wordBoxName = 'wordsBox';
// //   static const String idiomBoxName = 'idiomsBox';

// //   /// -------------------------------
// //   /// OPEN BOXES (called in main)
// //   /// -------------------------------
// //   static Future<void> openBoxes() async {
// //     if (!Hive.isBoxOpen(wordBoxName)) {
// //       await Hive.openBox<Word>(wordBoxName);
// //     }
// //     if (!Hive.isBoxOpen(idiomBoxName)) {
// //       await Hive.openBox<Idiom>(idiomBoxName);
// //     }
// //   }

// //   /// -------------------------------
// //   /// READ
// //   /// -------------------------------
// //   static List<Word> getCachedWords() {
// //     final box = Hive.box<Word>(wordBoxName);
// //     return box.values.toList();
// //   }

// //   static List<Idiom> getCachedIdioms() {
// //     final box = Hive.box<Idiom>(idiomBoxName);
// //     return box.values.toList();
// //   }

// //   /// -------------------------------
// //   /// WRITE / UPDATE
// //   /// -------------------------------
// //   static Future<void> saveWord(Word word) async {
// //     final box = Hive.box<Word>(wordBoxName);
// //     await box.put(word.id, word);
// //   }

// //   static Future<void> saveIdiom(Idiom idiom) async {
// //     final box = Hive.box<Idiom>(idiomBoxName);
// //     await box.put(idiom.id, idiom);
// //   }

// //   /// -------------------------------
// //   /// BULK SAVE (FROM SUPABASE)
// //   /// -------------------------------
// //   static Future<void> cacheWords(List<Word> words) async {
// //     final box = Hive.box<Word>(wordBoxName);
// //     final Map<dynamic, Word> map = {
// //       for (var word in words) word.id: word
// //     };
// //     await box.putAll(map);
// //   }

// //   static Future<void> cacheIdioms(List<Idiom> idioms) async {
// //     final box = Hive.box<Idiom>(idiomBoxName);
// //     final Map<dynamic, Idiom> map = {
// //       for (var idiom in idioms) idiom.id: idiom
// //     };
// //     await box.putAll(map);
// //   }

// //   /// -------------------------------
// //   /// SYNC PLACEHOLDER (SAFE CALL)
// //   /// -------------------------------
// //   static Future<void> syncAllIfNeeded() async {
// //     // For now: no-op
// //     // Later: check timestamps + fetch Supabase
// //     return;
// //   }
// // }


// import 'package:hive/hive.dart';
// import 'package:kenyandictionaryapp/models/word.dart';
// import 'package:kenyandictionaryapp/models/idiom.dart';

// class CacheService {
//   static const String wordBoxName = 'wordsBox';
//   static const String idiomBoxName = 'idiomsBox';
//   static const String metaBoxName = 'metaBox';

//   /// -------------------------------
//   /// OPEN BOXES (called in main)
//   /// -------------------------------
//   static Future<void> openBoxes() async {
//     if (!Hive.isBoxOpen(wordBoxName)) {
//       await Hive.openBox<Word>(wordBoxName);
//     }
//     if (!Hive.isBoxOpen(idiomBoxName)) {
//       await Hive.openBox<Idiom>(idiomBoxName);
//     }
//     if (!Hive.isBoxOpen(metaBoxName)) {
//       await Hive.openBox(metaBoxName);
//     }
//   }

//   /// -------------------------------
//   /// READ ALL
//   /// -------------------------------
//   static List<Word> getCachedWords() {
//     final box = Hive.box<Word>(wordBoxName);
//     return box.values.toList();
//   }

//   static List<Idiom> getCachedIdioms() {
//     final box = Hive.box<Idiom>(idiomBoxName);
//     return box.values.toList();
//   }

//   /// -------------------------------
//   /// READ SINGLE (by ID)
//   /// -------------------------------
//   static Word? getWordById(int id) {
//     final box = Hive.box<Word>(wordBoxName);
//     return box.get(id);
//   }

//   static Idiom? getIdiomById(int id) {
//     final box = Hive.box<Idiom>(idiomBoxName);
//     return box.get(id);
//   }

//   /// -------------------------------
//   /// SAVE / UPDATE SINGLE ITEM
//   /// -------------------------------
//   static Future<void> saveWord(Word word) async {
//     final box = Hive.box<Word>(wordBoxName);
//     await box.put(word.id, word);
//   }

//   static Future<void> saveIdiom(Idiom idiom) async {
//     final box = Hive.box<Idiom>(idiomBoxName);
//     await box.put(idiom.id, idiom);
//   }

//   /// -------------------------------
//   /// BULK SAVE (FROM SUPABASE)
//   /// -------------------------------
//   static Future<void> cacheWords(List<Word> words) async {
//     final box = Hive.box<Word>(wordBoxName);
//     final Map<dynamic, Word> map = {for (var w in words) w.id: w};
//     await box.putAll(map);
//   }

//   static Future<void> cacheIdioms(List<Idiom> idioms) async {
//     final box = Hive.box<Idiom>(idiomBoxName);
//     final Map<dynamic, Idiom> map = {for (var i in idioms) i.id: i};
//     await box.putAll(map);
//   }

//   /// -------------------------------
//   /// GET WORD / IDIOM OF THE DAY
//   /// -------------------------------
//   static Word? getWordOfTheDay(int dayIndex) {
//     final words = getCachedWords();
//     if (words.isEmpty) return null;
//     return words[dayIndex % words.length];
//   }

//   static Idiom? getIdiomOfTheDay(int dayIndex) {
//     final idioms = getCachedIdioms();
//     if (idioms.isEmpty) return null;
//     return idioms[dayIndex % idioms.length];
//   }

//   /// -------------------------------
//   /// BOOKMARKS
//   /// -------------------------------
//   static Future<void> toggleWordBookmark(Word word) async {
//     word.isBookmarked = !word.isBookmarked;
//     await saveWord(word);
//   }

//   static Future<void> toggleIdiomBookmark(Idiom idiom) async {
//     idiom.isBookmarked = !idiom.isBookmarked;
//     await saveIdiom(idiom);
//   }

//   static List<Word> getBookmarkedWords() {
//     return getCachedWords().where((w) => w.isBookmarked).toList();
//   }

//   static List<Idiom> getBookmarkedIdioms() {
//     return getCachedIdioms().where((i) => i.isBookmarked).toList();
//   }

//   /// -------------------------------
//   /// META BOX (timestamps / flags)
//   /// -------------------------------
//   static Future<void> setMeta(String key, dynamic value) async {
//     final box = Hive.box(metaBoxName);
//     await box.put(key, value);
//   }

//   static dynamic getMeta(String key) {
//     final box = Hive.box(metaBoxName);
//     return box.get(key);
//   }

//   /// -------------------------------
//   /// SYNC PLACEHOLDER
//   /// -------------------------------
//   static Future<void> syncAllIfNeeded() async {
//     // Could check timestamps here and fetch from Supabase if needed
//     return;
//   }
// }


import 'package:hive/hive.dart';
import 'package:kenyandictionaryapp/models/word.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';

class CacheService {
  static const String wordBoxName = 'wordsBox';
  static const String idiomBoxName = 'idiomsBox';
  static const String metaBoxName = 'metaBox'; // for timestamps, flags, etc.

  /// -------------------------------
  /// OPEN BOXES (called in main)
  /// -------------------------------
  static Future<void> openBoxes() async {
    if (!Hive.isBoxOpen(wordBoxName)) {
      await Hive.openBox<Word>(wordBoxName);
    }
    if (!Hive.isBoxOpen(idiomBoxName)) {
      await Hive.openBox<Idiom>(idiomBoxName);
    }
    if (!Hive.isBoxOpen(metaBoxName)) {
      await Hive.openBox(metaBoxName);
    }
  }

  /// -------------------------------
  /// GET ALL CACHED ITEMS
  /// -------------------------------
  static List<Word> getCachedWords() {
    final box = Hive.box<Word>(wordBoxName);
    return box.values.toList();
  }

  static List<Idiom> getCachedIdioms() {
    final box = Hive.box<Idiom>(idiomBoxName);
    return box.values.toList();
  }

  /// -------------------------------
  /// SAVE / UPDATE SINGLE ITEM
  /// -------------------------------
  static Future<void> saveWord(Word word) async {
    final box = Hive.box<Word>(wordBoxName);
    await box.put(word.id, word);
  }

  static Future<void> saveIdiom(Idiom idiom) async {
    final box = Hive.box<Idiom>(idiomBoxName);
    await box.put(idiom.id, idiom);
  }

  /// -------------------------------
  /// BULK SAVE (FROM SUPABASE)
  /// -------------------------------
  static Future<void> cacheWords(List<Word> words) async {
    final box = Hive.box<Word>(wordBoxName);
    final Map<dynamic, Word> map = {for (var w in words) w.id: w};
    await box.putAll(map);
  }

  static Future<void> cacheIdioms(List<Idiom> idioms) async {
    final box = Hive.box<Idiom>(idiomBoxName);
    final Map<dynamic, Idiom> map = {for (var i in idioms) i.id: i};
    await box.putAll(map);
  }

  /// -------------------------------
  /// CLEAR BOXES
  /// -------------------------------
  static Future<void> clearWords() async {
    await Hive.box<Word>(wordBoxName).clear();
  }

  static Future<void> clearIdioms() async {
    await Hive.box<Idiom>(idiomBoxName).clear();
  }

  /// -------------------------------
  /// SYNC / FUTURE USE
  /// -------------------------------
  static Future<void> syncAllIfNeeded() async {
    // Placeholder: can check timestamps in metaBox to decide if fetching fresh data is needed
    // For now, no-op
    return;
  }
}
