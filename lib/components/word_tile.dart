// 

import 'package:flutter/material.dart';
import 'package:kenyandictionaryapp/models/word.dart';

class WordTile extends StatelessWidget {
  final Word word;
  final VoidCallback? onBookmarkToggle;

  const WordTile({super.key, required this.word, this.onBookmarkToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(
          word.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(word.meaning),
        trailing: IconButton(
          icon: Icon(
            word.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: word.isBookmarked ? Colors.blueAccent : Colors.grey,
          ),
          onPressed: onBookmarkToggle, // Simply call the callback
        ),
      ),
    );
  }
}