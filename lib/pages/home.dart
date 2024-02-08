import 'package:absoftexamination/pages/login.dart';
import 'package:absoftexamination/pages/signUp.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(
//       home: HomePage(),
//     ));

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Center(
                    child: Image.asset(
                  'assets/quizer_logo.png',
                  width: 300,
                  height: 150,
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Quizer',
                    style: TextStyle(
                        color: Color(0xFF3559E0),
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom:
                20, // Adjust the value to change the vertical position of the buttons
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/login');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF3559E0)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white) // Change to your desired color
                        ),
                    child: Text(
                      'Log In',
                      // style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10), // Add space between buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignUpPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all<Color>(Color(
                          0xFF3559E0)), // Change to your desired text color
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                            color: Color(0xFF3559E0),
                            width:
                                2.0), // Change to your desired border color and width
                      ),
                    ),
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
