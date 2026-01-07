class Word {
  final int id;
  final String name;
  final String? type;
  final String meaning;
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'meaning': meaning,
      'is_bookmarked': isBookmarked,
    };
  }
}



// class Word {
//   final String name;
//   final String meaning;
//   bool isBookmarked;

//   Word({
//     required this.name,
//     required this.meaning,
//     this.isBookmarked = false,
//   });
// }
