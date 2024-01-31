import 'dart:convert';

import 'package:absoftexamination/providers/auth.dart';
import 'package:absoftexamination/services/api.dart';
import 'package:absoftexamination/utility/validators.dart';
import 'package:absoftexamination/utility/widget.dart';
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
      home: LoginPage(),
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');

      try {
        var requestBody = http.MultipartRequest('POST', Uri.parse(Api.authUrl))
          ..fields['email'] = _emailController.text
          ..fields['password'] = _passwordController.text;

        final response = await requestBody.send();

        final Map<String, dynamic> responseMap =
            json.decode(await response.stream.bytesToString());

        if (responseMap['header']['error'].toLowerCase() == 'false') {
          context.read<UserDataProvider>().setUserData(responseMap['data']);

          print('Login successful');
          Navigator.pushNamed(context, '/examhome');
        } else {
          // Login failed, handle the error response
          print('Login failed: ${responseMap['header']['message']}');
          // Optionally, display an error message to the user
        }
      } catch (e) {
        // Handle network or other errors
        print('Error during login: $e');
        // Optionally, display an error message to the user
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                    Row(
                      children: [
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
                      ],
                    ),
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
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 50,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.grey,
                          style:
                              TextStyle(color: Color.fromARGB(255, 92, 91, 91)),
                          decoration: buildInputDecoration('Email'),
                          validator: validateEmail,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passwordController,

                          cursorColor: Colors.grey, // Change cursor color
                          style:
                              TextStyle(color: Color.fromARGB(255, 92, 91, 91)),
                          decoration: buildInputDecoration('Password'),
                          validator: validatePassword,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF3559E0)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          child: Text('Log In'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
