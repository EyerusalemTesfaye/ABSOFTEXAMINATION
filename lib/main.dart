import 'package:absoftexamination/pages/exam.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/login.dart';
import 'package:absoftexamination/pages/signUp.dart';
import 'package:absoftexamination/pages/takeExam.dart';
import 'package:absoftexamination/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => UserDataProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
            '/login': (context) => LoginPage(),
            '/signup': (context) => SignUpPage(),
            '/takeexam': (context) => TakeExam(),
            '/exam': (context) => Exam(),
            '/examhome': (context) => ExamHome(),
          },
        ),
      ),
    );
