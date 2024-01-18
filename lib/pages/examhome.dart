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
      backgroundColor: Color(0xFF16235A),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color.fromARGB(255, 129, 127, 127),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select The Exam',
                      style: TextStyle(
                          color: Color.fromARGB(255, 129, 127, 127),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Color.fromARGB(255, 129, 127, 127),
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
                              )),
                              PopupMenuItem(
                                  child: Center(
                                child: Text('Exams'),
                              )),
                              PopupMenuItem(
                                  child: Center(
                                child: Text('Logout'),
                              )),
                            ]);
                      },
                    ),
                  )
                ],
              )),
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Card(
                        color: Color(0xFF3F4D8B),
                        // Add elevation and set border radius for rounded corners
                        //elevation: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          width: 300,
                          height: 150,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  'Introduction to Quadratic',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color.fromARGB(255, 129, 127, 127),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '[1] English Subject Questions',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color:
                                          Color.fromARGB(255, 129, 127, 127)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'TAKE EXAM',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 129, 127, 127)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      )),
    );
  }
}
