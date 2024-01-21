import 'package:flutter/material.dart';

class ExamHome extends StatefulWidget {
  const ExamHome({super.key});

  @override
  State<ExamHome> createState() => _ExamHomeState();
}

class _ExamHomeState extends State<ExamHome> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF4042C9),
              padding: EdgeInsets.all(0),
              child: Stack(
                children: [
                  ClipPath(
                    clipper: myClipper(),
                    child: Container(
                      width: 400,
                      height: 400,
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(400)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: Color(0xFF16235A),
    //   body: SafeArea(
    //       child: Stack(
    //     children: <Widget>[
    //       Positioned(
    //           top: 10,
    //           left: 0,
    //           right: 0,
    //           child: Row(
    //             children: <Widget>[
    //               Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Padding(
    //                   padding: EdgeInsets.symmetric(horizontal: 10),
    //                   child: IconButton(
    //                       onPressed: () {
    //                         Navigator.pushNamed(context, '/login');
    //                       },
    //                       icon: Icon(
    //                         Icons.arrow_back,
    //                         color: Color.fromARGB(255, 129, 127, 127),
    //                       )),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: screenWidth * 0.07,
    //               ),
    //               Align(
    //                 alignment: Alignment.center,
    //                 child: Text(
    //                   'Select The Exam',
    //                   style: TextStyle(
    //                       color: Color.fromARGB(255, 129, 127, 127),
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: screenWidth * 0.2,
    //               ),
    //               Align(
    //                 alignment: Alignment.centerRight,
    //                 child: IconButton(
    //                   icon: Icon(
    //                     Icons.more_horiz,
    //                     color: Color.fromARGB(255, 129, 127, 127),
    //                   ),
    //                   onPressed: () {
    //                     showMenu(
    //                         shape: Border.all(),
    //                         color: Color(0xFF3F4D8B),
    //                         context: context,
    //                         position: RelativeRect.fromLTRB(82, 82, 0, 0),
    //                         items: [
    //                           PopupMenuItem(
    //                               child: Center(
    //                             child: Text(
    //                               'Results',
    //                               style: TextStyle(
    //                                 color: Color.fromARGB(255, 129, 127, 127),
    //                               ),
    //                             ),
    //                           )),
    //                           PopupMenuItem(
    //                               child: Center(
    //                             child: Text(
    //                               'Exams',
    //                               style: TextStyle(
    //                                 color: Color.fromARGB(255, 129, 127, 127),
    //                               ),
    //                             ),
    //                           )),
    //                           PopupMenuItem(
    //                               child: Center(
    //                             child: Text(
    //                               'Logout',
    //                               style: TextStyle(
    //                                 color: Color.fromARGB(255, 129, 127, 127),
    //                               ),
    //                             ),
    //                           )),
    //                         ]);
    //                   },
    //                 ),
    //               )
    //             ],
    //           )),
    //       Positioned(
    //           top: 100,
    //           left: 0,
    //           right: 0,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Align(
    //                 alignment: Alignment.center,
    //                 child: Container(
    //                   child: Card(
    //                     color: Color(0xFF3F4D8B),
    //                     // Add elevation and set border radius for rounded corners
    //                     //elevation: 50,
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(15.0),
    //                     ),
    //                     child: SizedBox(
    //                       width: 300,
    //                       height: 150,
    //                       child: Padding(
    //                         padding: EdgeInsets.all(20.0),
    //                         child: Column(
    //                           mainAxisSize: MainAxisSize.max,
    //                           children: <Widget>[
    //                             Text(
    //                               'Introduction to Quadratic',
    //                               style: TextStyle(
    //                                   fontSize: 18.0,
    //                                   color: Color.fromARGB(255, 129, 127, 127),
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                             SizedBox(height: 10),
    //                             Text(
    //                               '[1] English Subject Questions',
    //                               style: TextStyle(
    //                                   fontSize: 16.0,
    //                                   color:
    //                                       Color.fromARGB(255, 129, 127, 127)),
    //                             ),
    //                             SizedBox(
    //                               height: 10,
    //                             ),
    //                             Expanded(
    //                               child: OutlinedButton(
    //                                 onPressed: () {
    //                                   // Handle button press
    //                                 },
    //                                 style: OutlinedButton.styleFrom(
    //                                   side: BorderSide(
    //                                     color: Color.fromARGB(255, 129, 127,
    //                                         127), // Outline color
    //                                   ),
    //                                 ),
    //                                 child: Text(
    //                                   'TAKE EXAM',
    //                                   style: TextStyle(
    //                                     fontSize: 14,
    //                                     color:
    //                                         Color.fromARGB(255, 129, 127, 127),
    //                                   ),
    //                                 ),
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           )),
    //       Positioned(
    //           top: 270,
    //           left: 0,
    //           right: 0,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Align(
    //                 alignment: Alignment.center,
    //                 child: Container(
    //                   child: Card(
    //                     color: Color(0xFF3F4D8B),
    //                     // Add elevation and set border radius for rounded corners
    //                     //elevation: 50,
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(15.0),
    //                     ),
    //                     child: SizedBox(
    //                       width: 300,
    //                       height: 150,
    //                       child: Padding(
    //                         padding: EdgeInsets.all(20.0),
    //                         child: Column(
    //                           mainAxisSize: MainAxisSize.max,
    //                           children: <Widget>[
    //                             Text(
    //                               'System Administrator',
    //                               style: TextStyle(
    //                                   fontSize: 18.0,
    //                                   color: Color.fromARGB(255, 129, 127, 127),
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                             SizedBox(height: 10),
    //                             Text(
    //                               '[3] English Subject Questions',
    //                               style: TextStyle(
    //                                   fontSize: 16.0,
    //                                   color:
    //                                       Color.fromARGB(255, 129, 127, 127)),
    //                             ),
    //                             SizedBox(
    //                               height: 10,
    //                             ),
    //                             Expanded(
    //                               child: OutlinedButton(
    //                                 onPressed: () {
    //                                   // Handle button press
    //                                 },
    //                                 style: OutlinedButton.styleFrom(
    //                                   side: BorderSide(
    //                                     color: Color.fromARGB(255, 129, 127,
    //                                         127), // Outline color
    //                                   ),
    //                                 ),
    //                                 child: Text(
    //                                   'TAKE EXAM',
    //                                   style: TextStyle(
    //                                     fontSize: 14,
    //                                     color:
    //                                         Color.fromARGB(255, 129, 127, 127),
    //                                   ),
    //                                 ),
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ))
    //     ],
    //   )),
    // );
  }
}

class myClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);
    final secondfirstCurve = Offset(0, size.height - 20);
    final secondlastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondfirstCurve.dx, secondfirstCurve.dy,
        secondlastCurve.dx, secondlastCurve.dy);
    final thirdfirstCurve = Offset(size.width, size.height - 20);
    final thirdlastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdfirstCurve.dy, thirdfirstCurve.dy,
        thirdlastCurve.dx, thirdlastCurve.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
