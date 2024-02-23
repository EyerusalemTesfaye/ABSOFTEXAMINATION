import 'dart:convert';

import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/login.dart';
import 'package:absoftexamination/providers/auth.dart';
import 'package:absoftexamination/services/api.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:absoftexamination/util/validators.dart';
import 'package:absoftexamination/util/widget.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

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
  //const SignUpPage({super.key});
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _gradeController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Perform registration logic here
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Age: ${_ageController.text}');
      print('Grade: ${_gradeController.text}');
      print('Password: ${_passwordController.text}');
      print('Confirm Password: ${_confirmpasswordController.text}');

      // Rest of your signUp logic...

      try {
        var requestBody = http.MultipartRequest(
          'POST',
          Uri.parse(Api.userUrl),
        )
          ..fields['name'] = _nameController.text
          ..fields['email'] = _emailController.text
          ..fields['age'] = _ageController.text
          ..fields['grade'] = _gradeController.text
          ..fields['password'] = _passwordController.text
          ..fields['confirm_password'] = _confirmpasswordController.text;

        final response = await requestBody.send();
        final Map<String, dynamic> responseMap =
            json.decode(await response.stream.bytesToString());

        if (responseMap['header']['error'].toLowerCase() == 'false') {
          context.read<UserDataProvider>().setUserData(responseMap['data']);

          print('Registration successful');
          Navigator.pushNamed(context, LoginScreen);
        } else {
          // Registration failed, handle the error response
          print('Registration failed: ${responseMap['header']['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${responseMap['header']['message']}'),
          ),
        );
          // Optionally, display an error message to the user
        }
      } catch (e) {
        // Handle network or other errors
        print('Error during registration: $e');

        // Optionally, display an error message to the user
      } finally {
      setState(() {
        _isLoading = false; // Stop loading indicator
      });
    }
    }
  }

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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomePage(),
                                ),
                              );
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                          controller: _nameController,
                          cursorColor: Colors.grey,
                          style: TextStyle(
                              color: Color.fromRGBO(237, 234, 234, 1)),
                          decoration: buildInputDecoration('Full Name'),
                          validator: validateName),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.grey,
                        style:
                            TextStyle(color: Color.fromRGBO(237, 234, 234, 1)),
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
                              keyboardType: TextInputType.number,
                              controller: _ageController,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                  color: Color.fromRGBO(237, 234, 234, 1)),
                              decoration: buildInputDecoration('Age'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter age';
                                }

                                // Additional validation for age (e.g., must be a number)
                                bool isNumeric(String? value) {
                                  if (value == null) {
                                    return false;
                                  }
                                  return double.tryParse(value) != null;
                                }

                                return null;
                              },
                              //validator: validateEmail,
                            ),
                          ),
                          SizedBox(width: 5), // Spacer between Age and Grade
                          Expanded(
                            child: TextFormField(
                                controller: _gradeController,
                                cursorColor: Colors.grey,
                                style: TextStyle(
                                    color: Color.fromRGBO(237, 234, 234, 1)),
                                decoration: buildInputDecoration('Grade'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please enter grade';
                                  }
                                }
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
                        controller: _passwordController,

                        cursorColor: Colors.grey, // Change cursor color
                        style:
                            TextStyle(color: Color.fromRGBO(237, 234, 234, 1)),
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
                        controller: _confirmpasswordController,

                        cursorColor: Colors.grey, // Change cursor color
                        style:
                            TextStyle(color: Color.fromRGBO(237, 234, 234, 1)),
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
                        onPressed: _signUp,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF3559E0)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white) // Change to your desired color
                            ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                'Sign Up',
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
