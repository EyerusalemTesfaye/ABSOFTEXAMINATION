import 'package:flutter/material.dart';
import 'package:absoftexamination/pages/dinamicForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // TextEditingController _TextEditingController = TextEditingController();
    // String _inputText = '';
    // @override
    // void dispose() {
    //   _TextEditingController.dispose();
    //   super.dispose();
    // }

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
                    image: AssetImage('assets/login_design.jpg'),
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
                            'Log In',
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
                bottom: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // CustomInputDecorations.buildTextField(
                    //   labelText: 'Email',
                    // ),
                    // SizedBox(height: 20),

                    // CustomInputDecorations.buildTextField(
                    //   labelText: 'Password',
                    // ),
                    // SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        cursorColor: Colors.grey, // Change cursor color
                        style:
                            TextStyle(color: Color.fromARGB(255, 92, 91, 91)),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF3559E0))),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 92, 91, 91)),
                          filled: true,
                          fillColor: Colors.blueGrey[900],
                          floatingLabelBehavior: FloatingLabelBehavior
                              .auto, // Set floating label behavior

                          contentPadding: EdgeInsets.fromLTRB(
                              12, 20, 12, 8), // Adjust content padding
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        cursorColor: Colors.grey, // Change cursor color
                        style: TextStyle(color: Colors.grey),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF3559E0))),
                            labelText: 'Password',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 4),
                            floatingLabelBehavior: FloatingLabelBehavior
                                .auto // Adjust content padding
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/examhome');
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF3559E0)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white) // Change to your desired color
                            ),
                        child: Text(
                          'Log In',
                          // style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
