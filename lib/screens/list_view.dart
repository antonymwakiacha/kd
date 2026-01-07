import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListViewTest extends StatelessWidget {
  const ListViewTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: 200,
              color: Colors.red,
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              width: 200,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
