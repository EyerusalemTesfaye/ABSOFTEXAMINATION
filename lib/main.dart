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

import 'package:absoftexamination/pages/exam.dart';
import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/pages/login.dart';
import 'package:absoftexamination/pages/signUp.dart';
//import 'package:absoftexamination/pages/takeExam.dart';
import 'package:absoftexamination/providers/auth.dart';
import 'package:absoftexamination/providers/examData.dart';
import 'package:absoftexamination/providers/question.dart';
import 'package:absoftexamination/providers/questionProvider.dart';
import 'package:absoftexamination/providers/resultShow.dart';
import 'package:absoftexamination/providers/userProvider.dart';
import 'package:absoftexamination/util/connection.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:absoftexamination/util/router_path.dart';
import 'package:absoftexamination/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Check internet connectivity
//   bool isInternetAvailable = await checkInternetConnectivity();
//   String initialRoute;

//   if (isInternetAvailable) {
//     // Check if a user is logged in
//     final bool isUserLoggedIn = await UserPreferences.isUserLoggedIn();
//     initialRoute = isUserLoggedIn ? ExamHomeScreen : HomeScreen;
//   } else {
//     // No internet connection, show home screen
//     initialRoute = HomeScreen;
//   }

//   runApp(MyApp(
//       initialRoute: initialRoute, isInternetAvailable: isInternetAvailable));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check internet connectivity
  bool isInternetAvailable = await checkInternetConnectivity();
  String initialRoute;

  if (isInternetAvailable) {
    // Check if a user is logged in
    final bool isUserLoggedIn = await UserPreferences.isUserLoggedIn();
    if (await UserPreferences.isFirstTime()) {
      // If it's the first time opening the app, show the GetStarted page
      initialRoute = FirstPreviewScreen;
      await UserPreferences.setFirstTime(
          false); // Set isFirstTime flag to false
    } else {
      // Otherwise, show the appropriate screen based on user login status
      initialRoute = isUserLoggedIn ? ExamHomeScreen : HomeScreen;
    }
  } else {
    // No internet connection, show home screen
    initialRoute = HomeScreen;
  }

  runApp(MyApp(
      initialRoute: initialRoute, isInternetAvailable: isInternetAvailable));
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  final bool isInternetAvailable;

  MyApp({required this.initialRoute, required this.isInternetAvailable});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        // Internet connection is available, trigger app reload
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isInternetAvailable) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text('You are not connect to internet!'),
          ),
        ),
      );
    }

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
        initialRoute: widget.initialRoute,
      ),
    );
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}
