import 'package:absoftexamination/util/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
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
              image: AssetImage('assets/third_preview1.png'),
              fit: BoxFit.fill,
            )),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Column(
                children: [
                  Text(
                    'Available anytime',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF2D54EF)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Discover helpful quizzes tailored to your interests',
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Savor the sweetness of knowledge with our delightful quizzes',
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 65,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/login');
                      Navigator.pushNamed(context, HomeScreen);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF07193F)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white) // Change to your desired color
                        ),
                    child: Text(
                      'Get Started',
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
