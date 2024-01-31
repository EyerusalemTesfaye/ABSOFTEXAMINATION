import 'package:absoftexamination/utility/validators.dart';
import 'package:absoftexamination/utility/widget.dart';
import 'package:flutter/material.dart';
import 'package:absoftexamination/pages/dinamicForm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
      theme: ThemeData(
        // Set the primary color for the input border
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green), // Set the border color
            borderRadius: BorderRadius.circular(8.0), // Set the border radius
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.blue), // Set the focused border color
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextEditingController _passwordController = new TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/signup_design.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Back',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      //controller: _emailController,
                      cursorColor: Colors.grey,
                      style: TextStyle(color: Color.fromRGBO(237, 234, 234, 1)),
                      decoration: buildInputDecoration('Full Name'),
                      //validator: validateEmail,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      // controller: _emailController,
                      cursorColor: Colors.grey,
                      style: TextStyle(color: Color.fromRGBO(237, 234, 234, 1)),
                      decoration: buildInputDecoration('Email'),
                      validator: validateEmail,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            //controller: _emailController,
                            cursorColor: Colors.grey,
                            style: TextStyle(
                                color: Color.fromRGBO(237, 234, 234, 1)),
                            decoration: buildInputDecoration('Age'),
                            //validator: validateEmail,
                          ),
                        ),
                        SizedBox(width: 5), // Spacer between Age and Grade
                        Expanded(
                          child: TextFormField(
                            //controller: _emailController,
                            cursorColor: Colors.grey,
                            style: TextStyle(
                                color: Color.fromRGBO(237, 234, 234, 1)),
                            decoration: buildInputDecoration('Grade'),
                            //validator: validateEmail,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      obscureText: true,
                      //controller: _passwordController,

                      cursorColor: Colors.grey, // Change cursor color
                      style: TextStyle(color: Color.fromRGBO(237, 234, 234, 1)),
                      decoration: buildInputDecoration('Password'),
                      validator: validatePassword,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      obscureText: true,
                      //controller: _passwordController,

                      cursorColor: Colors.grey, // Change cursor color
                      style: TextStyle(color: Color.fromRGBO(237, 234, 234, 1)),
                      decoration: buildInputDecoration('Confirm Password'),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Password doesnot match';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF3559E0)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white) // Change to your desired color
                          ),
                      child: Text(
                        'Sign Up',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
