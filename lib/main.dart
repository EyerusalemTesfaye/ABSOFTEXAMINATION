import 'package:absoftexamination/pages/exam.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/login.dart';
import 'package:absoftexamination/pages/signUp.dart';
import 'package:absoftexamination/pages/takeExam.dart';
import 'package:absoftexamination/providers/auth.dart';
import 'package:absoftexamination/providers/question.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:absoftexamination/util/router_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() => runApp(
//       ChangeNotifierProvider(
//         create: (context) => UserDataProvider(),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           initialRoute: '/',
//           routes: {
//             '/': (context) => HomePage(),
//             '/login': (context) => LoginPage(),
//             '/signup': (context) => SignUpPage(),
//             '/takeexam': (context) => TakeExam(),
//             '/exam': (context) => Exam(),
//             '/examhome': (context) => ExamHome(
//                   questions: [],
//                 ),
//           },
//         ),
//       ),
//     );

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => UserDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ExamProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routerr.generateRouter,
      initialRoute: HomeScreen,
    );
  }
}
