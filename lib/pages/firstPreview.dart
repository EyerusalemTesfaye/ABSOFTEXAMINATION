import 'package:absoftexamination/util/router.dart';
import 'package:flutter/material.dart';

class FirstPreview extends StatefulWidget {
  const FirstPreview({super.key});

  @override
  State<FirstPreview> createState() => _FirstPreviewState();
}

class _FirstPreviewState extends State<FirstPreview> {
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
              image: AssetImage('assets/first_preview1.png'),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Column(
                children: [
                  Text(
                    'Fast and Secure Quizer',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF2D54EF)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Challenge your knowledge ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Explore a world of quizzes and trivia',
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Test yourself with our diverse range of topics',
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 70,
                  ),

                  // Text('hey'),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/login');
                      Navigator.pushNamed(context, SecondPreviewScreen);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF07193F)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white) // Change to your desired color
                        ),
                    child: Text(
                      'Next',
                      // style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
