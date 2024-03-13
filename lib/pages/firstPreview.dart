// import 'package:absoftexamination/util/router.dart';
// import 'package:flutter/material.dart';

// class FirstPreview extends StatefulWidget {
//   const FirstPreview({super.key});

//   @override
//   State<FirstPreview> createState() => _FirstPreviewState();
// }

// class _FirstPreviewState extends State<FirstPreview> {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: screenHeight,
//             width: screenWidth,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//               image: AssetImage('assets/first_preview1.png'),
//               fit: BoxFit.cover,
//             )),
//           ),
//           Positioned(
//               left: 0,
//               right: 0,
//               bottom: 30,
//               child: Column(
//                 children: [
//                   const Text(
//                     'Fast and Secure Quizer',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 24,
//                         color: Color(0xFF2D54EF)),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text(
//                     'Challenge your knowledge ',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 199, 197, 197),
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const Text(
//                     'Explore a world of quizzes and trivia',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 199, 197, 197),
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text(
//                     'Test yourself with our diverse range of topics',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 199, 197, 197),
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 70,
//                   ),

//                   // Text('hey'),
//                   ElevatedButton(
//                     onPressed: () {
//                       //Navigator.pushNamed(context, '/login');
//                       Navigator.pushNamed(context, SecondPreviewScreen);
//                     },
//                     style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(Color(0xFF07193F)),
//                         foregroundColor: MaterialStateProperty.all<Color>(
//                             Colors.white) // Change to your desired color
//                         ),
//                     child: const Text(
//                       'Next',
//                       // style: TextStyle(color: Colors.white),
//                     ),
//                   )
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }

import 'package:absoftexamination/model/initalizer.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:flutter/material.dart';

class FirstPreview extends StatefulWidget {
  const FirstPreview({Key? key});

  @override
  State<FirstPreview> createState() => _FirstPreviewState();
}

class _FirstPreviewState extends State<FirstPreview> {
  int currentIndex = 0; // Keep track of the current index for accessing data

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Initials[currentIndex].image),
                fit: currentIndex == 0 ? BoxFit.cover : BoxFit.fill,
              ),
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 30,
          //   child: Column(
          //     children: [
          //       Text(
          //         Initials[currentIndex].description,
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 24,
          //           color: const Color(0xFF2D54EF),
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 10,
          //       ),
          //       ElevatedButton(
          //         onPressed: () {
          //           if (currentIndex < Initials.length - 1) {
          //             setState(() {
          //               currentIndex++;
          //             });
          //           } else {
          //             Navigator.pushNamed(context, SecondPreviewScreen);
          //           }
          //         },
          //         style: ButtonStyle(
          //           backgroundColor: MaterialStateProperty.all<Color>(
          //             const Color(0xFF07193F),
          //           ),
          //           foregroundColor: MaterialStateProperty.all<Color>(
          //             Colors.white,
          //           ),
          //         ),
          //         child: Text(
          //           currentIndex < Initials.length - 1 ? 'Next' : 'GetStarted',
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Column(
                children: [
                  Text(
                    Initials[currentIndex].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF2D54EF)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    Initials[currentIndex].description1,
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Initials[currentIndex].description2,
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Text(
                  //   'Satisfy your hunger for knowledge ',
                  //   style: TextStyle(
                  //       color: Color.fromARGB(255, 199, 197, 197),
                  //       fontWeight: FontWeight.bold),
                  // ),
                  SizedBox(
                    height: 45,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (currentIndex < Initials.length - 1) {
                        setState(() {
                          currentIndex++;
                        });
                      } else {
                        Navigator.pushNamed(context, SecondPreviewScreen);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF07193F),
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child: Text(
                      currentIndex < Initials.length - 1
                          ? 'Next'
                          : 'GetStarted',
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
