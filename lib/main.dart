// import 'package:absoftexamination/pages/exam.dart';
// import 'package:absoftexamination/pages/examhome.dart';
// import 'package:absoftexamination/pages/home.dart';
// import 'package:absoftexamination/pages/login.dart';
// import 'package:absoftexamination/pages/signUp.dart';
// import 'package:absoftexamination/pages/takeExam.dart';
// import 'package:absoftexamination/providers/auth.dart';
// import 'package:absoftexamination/providers/examData.dart';
// import 'package:absoftexamination/providers/question.dart';
// import 'package:absoftexamination/providers/questionProvider.dart';
// import 'package:absoftexamination/providers/resultShow.dart';
// import 'package:absoftexamination/providers/userProvider.dart';
// import 'package:absoftexamination/util/router.dart';
// import 'package:absoftexamination/util/router_path.dart';
// import 'package:absoftexamination/util/shared_preferences_util.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // void main() => runApp(
// //       ChangeNotifierProvider(
// //         create: (context) => UserDataProvider(),
// //         child: MaterialApp(
// //           debugShowCheckedModeBanner: false,
// //           initialRoute: '/',
// //           routes: {
// //             '/': (context) => HomePage(),
// //             '/login': (context) => LoginPage(),
// //             '/signup': (context) => SignUpPage(),
// //             '/takeexam': (context) => TakeExam(),
// //             '/exam': (context) => Exam(),
// //             '/examhome': (context) => ExamHome(
// //                   questions: [],
// //                 ),
// //           },
// //         ),
// //       ),
// //     );

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Check if a user is logged in
//   final bool isUserLoggedIn = await UserPreferences.isUserLoggedIn();
//   String initialRoute = isUserLoggedIn ? ExamHomeScreen : HomeScreen;

//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider(
//         create: (BuildContext context) => UserDataProvider(),
//       ),
//       ChangeNotifierProvider(create: (BuildContext context) => UserProvider()),
//       ChangeNotifierProvider(create: (_) => QuestionProvider()),
//       ChangeNotifierProvider(
//         create: (_) => ExamProvider(),
//       ),
//       ChangeNotifierProvider(
//         create: (_) => ExamDataProvider(),
//       ),
//       ChangeNotifierProvider(
//         create: (_) => ResultShowProvider(),
//       ),
//     ],
//     child: MyApp(initialRoute: initialRoute),
//   ));
// }

// class MyApp extends StatelessWidget {
//   final String initialRoute;

//   MyApp({required this.initialRoute});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: Routerr.generateRouter,
//       initialRoute: initialRoute,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'pages/exam.dart';
import 'pages/examhome.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/signUp.dart';
import 'pages/takeExam.dart';
import 'providers/auth.dart';
import 'providers/examData.dart';
import 'providers/question.dart';
import 'providers/questionProvider.dart';
import 'providers/resultShow.dart';
import 'providers/userProvider.dart';
import 'util/router.dart';
import 'util/router_path.dart';
import 'util/shared_preferences_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isInternetAvailable;
  late Future<String> initialRoute;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    initialRoute = _getInitialRoute();
  }

  Future<void> initConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isInternetAvailable = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: initialRoute,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (isInternetAvailable == null || !isInternetAvailable) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text('You are not connected to the internet!'),
                ),
              ),
            );
          } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (BuildContext context) => UserDataProvider(),
                ),
                ChangeNotifierProvider(
                    create: (BuildContext context) => UserProvider()),
                ChangeNotifierProvider(create: (_) => QuestionProvider()),
                ChangeNotifierProvider(
                  create: (_) => ExamProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => ExamDataProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => ResultShowProvider(),
                ),
              ],
              child: MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                onGenerateRoute: Routerr.generateRouter,
                initialRoute: snapshot.data ?? HomeScreen,
              ),
            );
          }
        }
      },
    );
  }

  Future<String> _getInitialRoute() async {
    bool isUserLoggedIn = await UserPreferences.isUserLoggedIn();
    return isUserLoggedIn ? ExamHomeScreen : HomeScreen;
  }
}
