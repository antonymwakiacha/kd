// 
import 'package:hive/hive.dart';

part 'idiom.g.dart';

@HiveType(typeId: 1)
class Idiom {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String phrase;

  @HiveField(2)
  final String meaning;

  @HiveField(3)
  bool isBookmarked;

  Idiom({
    required this.id,
    required this.phrase,
    required this.meaning,
    this.isBookmarked = false,
  });

  factory Idiom.fromJson(Map<String, dynamic> json) {
    return Idiom(
      id: json['id'],
      phrase: json['phrase'],
      meaning: json['meaning'],
      isBookmarked: json['is_bookmarked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'phrase': phrase,
        'meaning': meaning,
        'is_bookmarked': isBookmarked,
      };
}
