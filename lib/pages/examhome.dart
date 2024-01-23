import 'package:flutter/material.dart';

class ExamHome extends StatefulWidget {
  const ExamHome({Key? key}) : super(key: key);

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
            ClipPath(
              clipper: HomeClipper(),
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.25, // Adjust the height as needed
                color: Color(0xFF4042C9),
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: [
                    Positioned(
                      top: screenHeight *
                          0.07, // Adjust the top position as needed
                      right: 0,
                      left: 0,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth *
                                0.18, // Adjust the width as needed
                          ),
                          Text(
                            'Select Subject',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            width: screenWidth *
                                0.15, // Adjust the width as needed
                          ),
                          PopupMenuItem(
                            child: IconButton(
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showMenu(
                                  shape: Border.all(),
                                  context: context,
                                  position: RelativeRect.fromLTRB(82, 82, 0, 0),
                                  items: [
                                    PopupMenuItem(
                                      child: Center(
                                        child: Text('Results'),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: Center(
                                        child: Text('Exams'),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: Center(
                                        child: Text('Logout'),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Positioned(
                      top: screenHeight *
                          0.25, // Adjust the top position as needed
                      right: 0,
                      left: 0,
                      child: Card(
                        elevation: 2,
                        child: ClipPath(
                          child: Container(
                            height: screenHeight * 0.2,
                            width: screenWidth * 0.94,
                            child: Column(
                              children: [
                                Text(
                                  'ggggvvv',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Description'),
                                SizedBox(
                                  height: 10,
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    // Add your button click logic here
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Adjust the border radius as needed
                                    ),
                                    side: BorderSide(
                                        color: Colors
                                            .black), // Specify the border color
                                  ),
                                  child: Text('Start'),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Colors.green,
                                  width: 5,
                                ),
                              ),
                            ),
                          ),
                          clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
      firstCurve.dx,
      firstCurve.dy,
      lastCurve.dx,
      lastCurve.dy,
    );
    final secondfirstCurve = Offset(0, size.height - 20);
    final secondlastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(
      secondfirstCurve.dx,
      secondfirstCurve.dy,
      secondlastCurve.dx,
      secondlastCurve.dy,
    );
    final thirdfirstCurve = Offset(size.width, size.height - 20);
    final thirdlastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(
      thirdfirstCurve.dx,
      thirdfirstCurve.dy,
      thirdlastCurve.dx,
      thirdlastCurve.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
