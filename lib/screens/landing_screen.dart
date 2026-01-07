import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'landing_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(252, 252, 249, 232),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(145),
              child: Container(
                  height: 300,
                  width: 300,
                  child: Image.asset("lib/images/logoc.jpg")),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/home_screen'),
              child: Container(
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.only(
                  left: 70,
                  right: 50, 
                ),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border()),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
