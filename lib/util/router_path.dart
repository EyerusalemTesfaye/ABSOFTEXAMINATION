import 'package:absoftexamination/model/exam.dart';
import 'package:absoftexamination/pages/exam.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/login.dart';
import 'package:absoftexamination/pages/signUp.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:flutter/material.dart';

class Routerr {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        );
      case LoginScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        );
      case SignUpScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => SignUpPage(),
        );
      // case ExamHomeScreen:
      //   final argument = settings.arguments;
      //   if (argument is List<Question>) {
      //     return MaterialPageRoute(
      //       builder: (_) => ExamHome(
      //         questions: argument,
      //       ),
      //     );
      //   } else {
      //     // Handle the case where the argument is not of the expected type
      //     throw Exception('Invalid argument type for ExamHomeScreen');
      //   }
      case ExamHomeScreen:
        return MaterialPageRoute(builder: (BuildContext Context) => ExamHome());
      case ExamScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => Exam(),
        );
      // Add more cases for other routes if needed
      default:
        throw Exception('Unknown route: ${settings.name}');
    }
  }
}