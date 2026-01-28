// class Word {
//   final int id;
//   final String name;
//   final String? type;
//   final String meaning;
//   bool isBookmarked;

//   Word({
//     required this.id,
//     required this.name,
//     this.type,
//     required this.meaning,
//     this.isBookmarked = false,
//   });

//   factory Word.fromJson(Map<String, dynamic> json) {
//     return Word(
//       id: json['id'],
//       name: json['name'],
//       type: json['type'],
//       meaning: json['meaning'],
//       isBookmarked: json['is_bookmarked'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'type': type,
//       'meaning': meaning,
//       'is_bookmarked': isBookmarked,
//     };
//   }
// }


import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? type;

  @HiveField(3)
  final String meaning;

  @HiveField(4)
  bool isBookmarked;

  Word({
    required this.id,
    required this.name,
    this.type,
    required this.meaning,
    this.isBookmarked = false,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      meaning: json['meaning'],
      isBookmarked: json['is_bookmarked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'meaning': meaning,
        'is_bookmarked': isBookmarked,
      };
}
