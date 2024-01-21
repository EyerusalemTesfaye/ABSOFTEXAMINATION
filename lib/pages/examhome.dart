import 'package:flutter/material.dart';

class ExamHome extends StatefulWidget {
  const ExamHome({super.key});

  @override
  State<ExamHome> createState() => _ExamHomeState();
}

class _ExamHomeState extends State<ExamHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: HomeClipper(),
              child: Container(
                color: Color(0xFF4042C9),
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
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
                            width: 80,
                          ),
                          Text(
                            'Select Subject',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 100,
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
                    Positioned(
                      top: 200,
                      right: 0,
                      left: 0,
                      child: Card(
                        elevation: 2,
                        child: ClipPath(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
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
                ),
              ),
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
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);
    final secondfirstCurve = Offset(0, size.height - 20);
    final secondlastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondfirstCurve.dx, secondfirstCurve.dy,
        secondlastCurve.dx, secondlastCurve.dy);
    final thirdfirstCurve = Offset(size.width, size.height - 20);
    final thirdlastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdfirstCurve.dx, thirdfirstCurve.dy,
        thirdlastCurve.dx, thirdlastCurve.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
