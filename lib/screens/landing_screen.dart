// // // // 

// // // import 'package:flutter/material.dart';

// // // class LandingPage extends StatelessWidget {
// // //   const LandingPage({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFFCF9E8),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             ClipRRect(
// // //               borderRadius: BorderRadius.circular(145),
// // //               child: SizedBox(
// // //                 height: 300,
// // //                 width: 300,
// // //                 child: Image.asset("lib/images/logoc.jpg"),
// // //               ),
// // //             ),
// // //             const SizedBox(height: 30),
// // //             GestureDetector(
// // //               onTap: () {
// // //                 // Flutter Web-safe navigation
// // //                 Navigator.pushReplacementNamed(context, '/home_screen');
// // //               },
// // //               child: Container(
// // //                 padding: const EdgeInsets.all(25),
// // //                 margin: const EdgeInsets.symmetric(horizontal: 60),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.black,
// // //                   borderRadius: BorderRadius.circular(8),
// // //                 ),
// // //                 child: const Center(
// // //                   child: Text(
// // //                     "Get Started",
// // //                     style: TextStyle(
// // //                       color: Colors.white,
// // //                       fontWeight: FontWeight.bold,
// // //                       fontSize: 16,
// // //                       fontFamily: 'sans-serif',
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }


// // import 'package:flutter/material.dart';
// // import 'package:kenyandictionaryapp/models/word.dart';
// // import 'package:kenyandictionaryapp/models/idiom.dart';
// // import 'package:kenyandictionaryapp/services/cache_service.dart';
// // //import 'package:kenyandictionaryapp/utils/cache_service.dart';

// // class LandingPage extends StatefulWidget {
// //   const LandingPage({super.key});

// //   @override
// //   State<LandingPage> createState() => _LandingPageState();
// // }

// // class _LandingPageState extends State<LandingPage> {
// //   Word? wordOfTheDay;
// //   Idiom? idiomOfTheDay;
// //   String currentDate = '';

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadInitialData();
// //   }

// //   void _loadInitialData() {
// //     final now = DateTime.now();
// //     final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;

// //     // Format date
// //     final monthNames = [
// //       'January', 'February', 'March', 'April', 'May', 'June',
// //       'July', 'August', 'September', 'October', 'November', 'December'
// //     ];
// //     currentDate = '${monthNames[now.month - 1]} ${now.day}, ${now.year}';

// //     // Load from cache
// //     wordOfTheDay = CacheService.getWordOfTheDay(dayOfYear);
// //     idiomOfTheDay = CacheService.getIdiomOfTheDay(dayOfYear);

// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final screenWidth = MediaQuery.of(context).size.width;

// //     return Scaffold(
// //       backgroundColor: const Color.fromARGB(252, 252, 249, 232),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             // Logo
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(145),
// //               child: Container(
// //                   height: 300,
// //                   width: 300,
// //                   child: Image.asset("lib/images/logoc.jpg")),
// //             ),

// //             const SizedBox(height: 30),

// //             // Word of the Day preview
// //             Container(
// //               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
// //               margin: const EdgeInsets.symmetric(horizontal: 30),
// //               decoration: BoxDecoration(
// //                 color: Colors.black,
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: Column(
// //                 children: [
// //                   Text(
// //                     wordOfTheDay?.name ?? 'Word of the Day',
// //                     style: const TextStyle(
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 18,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 5),
// //                   Text(
// //                     wordOfTheDay?.meaning ?? '',
// //                     style: const TextStyle(color: Colors.white, fontSize: 14),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 15),

// //             // Idiom of the Day preview
// //             Container(
// //               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
// //               margin: const EdgeInsets.symmetric(horizontal: 30),
// //               decoration: BoxDecoration(
// //                 color: Colors.black,
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: Column(
// //                 children: [
// //                   Text(
// //                     idiomOfTheDay?.phrase ?? 'Idiom of the Day',
// //                     style: const TextStyle(
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 18,
// //                     ),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                   const SizedBox(height: 5),
// //                   Text(
// //                     idiomOfTheDay?.meaning ?? '',
// //                     style: const TextStyle(color: Colors.white, fontSize: 14),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 30),

// //             // Get Started button
// //             GestureDetector(
// //               onTap: () => Navigator.pushNamed(context, '/home_screen'),
// //               child: Container(
// //                 padding: const EdgeInsets.all(25),
// //                 margin: const EdgeInsets.symmetric(horizontal: 70),
// //                 decoration: BoxDecoration(
// //                   color: Colors.black,
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: const Center(
// //                   child: Text(
// //                     'Get Started',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 16,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),

// //             const SizedBox(height: 15),

// //             // Current Date
// //             Text(currentDate, style: const TextStyle(fontWeight: FontWeight.bold)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';

// class LandingPage extends StatelessWidget {
//   const LandingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCF9E8),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Logo
//             ClipRRect(
//               borderRadius: BorderRadius.circular(145),
//               child: SizedBox(
//                 height: 300,
//                 width: 300,
//                 child: Image.asset("lib/images/logoc.jpg"),
//               ),
//             ),
//             const SizedBox(height: 30),

//             // Get Started button
//             GestureDetector(
//               onTap: () => Navigator.pushNamed(context, '/home_screen'),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Text(
//                   'Get Started',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     fontFamily: 'sans-serif',
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9E8),
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
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/home_screen'),
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.only(left: 70, right: 50),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
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
