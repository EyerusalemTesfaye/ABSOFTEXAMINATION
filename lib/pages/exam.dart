import 'package:flutter/material.dart';

class Exam extends StatefulWidget {
  const Exam({super.key});

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 3, 33),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 61, 11, 240),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Absoft Exam Center',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4)
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              showMenu(
                shape: Border.all(color: Color.fromARGB(255, 61, 11, 240)),
                context: context,
                position: RelativeRect.fromLTRB(82, 82, 0, 0),
                items: [
                  PopupMenuItem(
                    child: Center(
                      child: Text(
                        'Results',
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 11, 240)),
                      ),
                    ),
                    value: '/result',
                  ),
                  PopupMenuItem(
                    child: Center(
                        child: Text(
                      'Exams',
                      style: TextStyle(color: Color.fromARGB(255, 61, 11, 240)),
                    )),
                    value: '/exam',
                  ),
                  PopupMenuItem(
                    child: Center(
                      child: Text(
                        'Logout',
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 11, 240)),
                      ),
                    ),
                    value: '/logout',
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'ffffffffffff',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
