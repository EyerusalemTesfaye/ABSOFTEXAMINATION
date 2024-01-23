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

            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 40,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: <Widget>[
            //       CustomInputDecorations.buildTextField(
            //         labelText: 'Full Name',
            //       ),
            //       SizedBox(height: 15),
            //       CustomInputDecorations.buildTextField(
            //         labelText: 'Email',
            //       ),
            //       SizedBox(height: 15),
            //       Row(
            //         children: [
            //           Flexible(
            //             child: CustomInputDecorations.buildTextField(
            //               labelText: 'Age',
            //             ),
            //           ),
            //           SizedBox(width: 5), // Adjust the width as needed
            //           Flexible(
            //             child: CustomInputDecorations.buildTextField(
            //               labelText: 'Grade',
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 15),
            //       CustomInputDecorations.buildTextField(
            //         labelText: 'Password',
            //       ),
            //       SizedBox(height: 15),
            //       CustomInputDecorations.buildTextField(
            //         labelText: 'Coniform Password',
            //       ),
            //       SizedBox(height: 20),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 100),
            //         child: ElevatedButton(
            //           onPressed: () {},
            //           style: ButtonStyle(
            //               backgroundColor: MaterialStateProperty.all<Color>(
            //                   Color(0xFF3559E0)),
            //               foregroundColor: MaterialStateProperty.all<Color>(
            //                   Colors.white) // Change to your desired color
            //               ),
            //           child: Text(
            //             'Log In',
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      cursorColor: const Color.fromARGB(
                          255, 156, 146, 146), // Change cursor color
                      style:
                          TextStyle(color: Color.fromARGB(255, 156, 146, 146)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // enabledBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(
                        //         color: Color.fromARGB(255, 156, 146, 146))),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 156, 146, 146),
                        ),
                        //contentPadding: EdgeInsets.symmetric(vertical: 8)
                        contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      cursorColor: Colors.white, // Change cursor color
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        filled: true,
                        fillColor: Color(0xFF),
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 156, 146, 146)),
                        contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
                      ),
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
                            cursorColor: Color.fromARGB(
                                255, 156, 146, 146), // Change cursor color
                            style: TextStyle(
                                color: Color.fromARGB(255, 156, 146, 146)),
                            decoration: const InputDecoration(
                              // enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color:
                              //             Color.fromARGB(255, 156, 146, 146))
                              //             ),
                              border: OutlineInputBorder(),
                              labelText: 'Age',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 156, 146, 146)),
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 20, 12, 8),
                            ),
                          ),
                        ),
                        //SizedBox(width: 10), // Spacer between Age and Grade
                        Expanded(
                          child: TextFormField(
                            cursorColor: Color.fromARGB(
                                255, 156, 146, 146), // Change cursor color
                            style: TextStyle(
                                color: Color.fromARGB(255, 156, 146, 146)),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Grade',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 156, 146, 146)),
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 20, 12, 8),
                            ),
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
                      cursorColor: Color.fromARGB(
                          255, 156, 146, 146), // Change cursor color
                      style:
                          TextStyle(color: Color.fromARGB(255, 156, 146, 146)),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 156, 146, 146)),
                        contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      cursorColor: Color.fromARGB(
                          255, 156, 146, 146), // Change cursor color
                      style:
                          TextStyle(color: Color.fromARGB(255, 156, 146, 146)),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: ' Confirm Password',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 156, 146, 146)),
                        contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
                      ),
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
