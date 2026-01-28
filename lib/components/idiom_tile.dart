// 

import 'package:flutter/material.dart';
import 'package:kenyandictionaryapp/models/idiom.dart';

class IdiomTile extends StatelessWidget {
  final Idiom idiom;
  final VoidCallback? onBookmarkToggle;

  const IdiomTile({super.key, required this.idiom, this.onBookmarkToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          idiom.phrase,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          idiom.meaning,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: Icon(
            idiom.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: idiom.isBookmarked ? Colors.amberAccent : Colors.grey,
          ),
          onPressed: onBookmarkToggle, // calls parent screen callback
        ),
      ),
    );
  }
}
