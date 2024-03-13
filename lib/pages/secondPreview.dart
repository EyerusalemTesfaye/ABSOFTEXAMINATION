import 'package:absoftexamination/util/router.dart';
import 'package:flutter/material.dart';

class SecondPreview extends StatefulWidget {
  const SecondPreview({super.key});

  @override
  State<SecondPreview> createState() => _SecondPreviewState();
}

class _SecondPreviewState extends State<SecondPreview> {
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
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/second_preview1.png'),
              fit: BoxFit.fill,
            )),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Column(
                children: [
                  const Text(
                    'Numerous Free Quizes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF2D54EF)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Feed your curiosity',
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Explore countless free quizzes',
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Satisfy your hunger for knowledge ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 199, 197, 197),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/login');
                      Navigator.pushNamed(context, GetStartedScreen);
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
