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
      child: ListTile(
        title: Text(
          idiom.phrase,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(idiom.meaning),
        trailing: IconButton(
          icon: Icon(
            idiom.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: idiom.isBookmarked ? Colors.blueAccent : Colors.grey,
          ),
          onPressed: onBookmarkToggle, // Delegate to parent widget
        ),
      ),
    );
  }
}