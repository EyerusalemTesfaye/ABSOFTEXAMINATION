import 'package:absoftexamination/model/exam.dart';
import 'package:absoftexamination/model/questionModal.dart';
import 'package:absoftexamination/pages/exam.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/login.dart';
import 'package:absoftexamination/pages/result.dart';
import 'package:absoftexamination/pages/showQuestion.dart';
import 'package:absoftexamination/pages/signUp.dart';
import 'package:absoftexamination/pages/soreResult.dart';
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
        // return MaterialPageRoute(
        //   builder: (BuildContext context) => Exam(

        //   ),
        // );

        return MaterialPageRoute(
          builder: (BuildContext context) {
            // final List<dynamic> choices =
            //     ModalRoute.of(context)!.settings.arguments as List<dynamic>;
            final List<dynamic> questions =
                ModalRoute.of(context)!.settings.arguments as List<dynamic>;
            return Exam(
                //choices: choices,
                questions: questions // Pass the choices argument here
                );
          },
        );
      case QuestionFinishScreen:
        return MaterialPageRoute(builder: (BuildContext context) {
          final List<dynamic> questions =
              ModalRoute.of(context)!.settings.arguments as List<dynamic>;
          final List<QuestionChoice> questionsList = [];
          return QuizFinishPage(
            title: null,
            questions: questions,
            questionsList: questionsList,
          );
        });
      case ShowQuestion:
        return MaterialPageRoute(builder: (BuildContext context) {
          final List<dynamic> questions =
              ModalRoute.of(context)!.settings.arguments as List<dynamic>;
          final List<QuestionChoice> questionsList = [];
          return ShowQuestionScreen(
            questions: questions,
            questionsList: questionsList,
          );
        });
      case ResultShowScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ResultScreen());
      // Add more cases for other routes if needed
      default:
        throw Exception('Unknown route: ${settings.name}');
    }
  }
}
