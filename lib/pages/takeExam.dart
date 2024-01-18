import 'package:flutter/material.dart';

class TakeExam extends StatefulWidget {
  const TakeExam({super.key});

  @override
  State<TakeExam> createState() => _TakeExamState();
}

class _TakeExamState extends State<TakeExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 10, 3, 33),
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

                //  onSelected: (value) {
                //   switch (value) {
                //     case '/result':
                //       Navigator.pushNamed(context, '/result');
                //       break;
                //     case '/exam':
                //       Navigator.pushNamed(context, '/exam');
                //       break;
                //     case '/logout':
                //       Navigator.pushNamed(context, '/logout');
                //       break;
                //     default:
                //       // Handle unknown value
                //       break;
                //   }
                // },
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Card(
          // Add elevation and set border radius for rounded corners
          elevation: 50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SizedBox(
            width: 480,
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Card Title',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Card Content',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
