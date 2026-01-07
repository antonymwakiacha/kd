import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kenyandictionaryapp/models/word.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<List<Word>> fetchWords() async {
    //final response = await supabase.from('words').select();

    final response = await Supabase.instance.client
        .from('words')
        .select('name, type, meaning');

    return response.map((json) => Word.fromJson(json)).toList();
  }

  Future<void> addWord(Word word) async {
    await supabase.from('words').insert({
      'name': word.name,
      'type': word.type,
      'meaning': word.meaning,
    });
  }
}
