import 'dart:convert';

import 'package:absoftexamination/model/exam.dart';
import 'package:absoftexamination/model/user.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/splash.dart';
import 'package:absoftexamination/pages/widget/awesomedialog.dart';
import 'package:absoftexamination/providers/auth.dart';
import 'package:absoftexamination/providers/userProvider.dart';
import 'package:absoftexamination/services/api.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:absoftexamination/util/shared_preferences_util.dart';
import 'package:absoftexamination/util/validators.dart';
import 'package:absoftexamination/util/widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
//import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/dialog.dart';

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
  bool _isLoading = false;
  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  List<Question> questions = [];
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
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
          context.read<UserProvider>().setUserData(responseMap['data']);
          print('Login successful');
          String token = responseMap['data']['token'];
          await UserPreferences.saveToken(responseMap['data']['token']);

          User? user = await UserPreferences.getUser() as User?;
          if (user != null) {
          } else {}
          context.read<UserProvider>().loginUser(
                User.fromMap(responseMap['data']),
                responseMap['data']['token'],
              );
          setState(() {
            _isLoading = true;
          });
          //await Future.delayed(const Duration(seconds: 3));
          // context.read<UserDataProvider>().setToken(token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SplashScreen()),
          );
          // Navigator.pushNamed(context, ExamHomeScreen, arguments: questions);
        } else {
          print('Login failed: ${responseMap['header']['message']}');

          // buildDialog(context, "Login Failed",
          //     '${responseMap['header']['message']}', DialogType.error, () {
          //   // Pop the dialog
          //   null;
          // }, () => null);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                //title: Text('Login Failed'),
                title: const Text("Login Failed"),
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                content: Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      ' ${responseMap['header']['message']}',
                      style: TextStyle(color: Colors.white),
                    )),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print('Error during login: $e');
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
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
                              style: TextStyle(
                                  color: Color.fromARGB(255, 92, 91, 91)),
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
                              style: TextStyle(
                                  color: Color.fromARGB(255, 92, 91, 91)),
                              decoration: buildInputDecoration('Password'),
                              validator: validatePassword,
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 100),
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF3559E0)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              child
                                  // : _isLoading
                                  //     ? CircularProgressIndicator(
                                  //         valueColor: AlwaysStoppedAnimation<Color>(
                                  //             Colors.white),
                                  //       )
                                  : Text('Log In'),
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
        ),
        if (_isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
