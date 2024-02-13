import 'package:absoftexamination/pages/exam.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/login.dart';
import 'package:absoftexamination/pages/signUp.dart';
import 'package:absoftexamination/pages/takeExam.dart';
import 'package:absoftexamination/providers/auth.dart';
import 'package:absoftexamination/providers/question.dart';
import 'package:absoftexamination/providers/userProvider.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:absoftexamination/util/router_path.dart';
import 'package:absoftexamination/util/shared_preferences_util.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if a user is logged in
  final bool isUserLoggedIn = await UserPreferences.isUserLoggedIn();
  String initialRoute = isUserLoggedIn ? ExamHomeScreen : HomeScreen;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => UserDataProvider(),
      ),
      ChangeNotifierProvider(create: (BuildContext context) => UserProvider()),
      ChangeNotifierProvider(
        create: (_) => ExamProvider(),
      )
    ],
    child: MyApp(initialRoute: initialRoute),
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routerr.generateRouter,
      initialRoute: initialRoute,
    );
  }
}
