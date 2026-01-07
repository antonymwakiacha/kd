class Idiom {
  final int id;
  final String phrase;
  final String meaning;
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phrase': phrase,
      'meaning': meaning,
      'is_bookmarked': isBookmarked,
    };
  }
}

