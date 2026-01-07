import 'package:flutter/material.dart';
import 'package:kenyandictionaryapp/models/dictionary.dart';

class DictListViewBuilder extends StatefulWidget {
  const DictListViewBuilder({super.key});

  @override
  State<DictListViewBuilder> createState() => _DictListViewBuilderState();
}

class _DictListViewBuilderState extends State<DictListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context,index){
        //Dictionary _dictionary = value.getDictionaryList()[index];
        //Dictionary _dictionary = value.get
      },
    );
  }
}