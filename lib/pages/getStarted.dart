import 'package:absoftexamination/model/initalizer.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // Swiped right
          if (currentIndex > 0) {
            setState(() {
              currentIndex--;
            });
          }
        } else {
          // Swiped left
          if (currentIndex < Initials.length - 1) {
            setState(() {
              currentIndex++;
            });
          } else {
            Navigator.pushNamed(context, HomeScreen);
          }
        }
      },
      child: Scaffold(
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
            Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Column(
                children: [
                  Text(
                    Initials[currentIndex].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFF2D54EF),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Initials[currentIndex].description1,
                    style: TextStyle(
                      color: Color.fromARGB(255, 199, 197, 197),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Initials[currentIndex].description2,
                    style: TextStyle(
                      color: Color.fromARGB(255, 199, 197, 197),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (indexDots) {
                      return Container(
                        //margin: EdgeInsets.only(left: 50),
                        height: 8,
                        width: currentIndex == indexDots ? 25 : 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF07193F)),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: screenWidth * 0.5, // Adjust the width as needed
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentIndex < Initials.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          Navigator.pushNamed(context, HomeScreen);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF07193F),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      child: Text(
                        currentIndex < Initials.length - 1
                            ? 'Next'
                            : 'Get Started',
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
