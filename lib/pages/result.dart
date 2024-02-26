import 'package:absoftexamination/pages/examhome.dart';
import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/providers/resultShow.dart';
import 'package:absoftexamination/util/router.dart';
import 'package:absoftexamination/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absoftexamination/model/resultShowModel.dart';
//import 'package:absoftexamination/provider/result_show_provider.dart'; // Import your provider file

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var showResult = Provider.of<ResultShowProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
          // Consumer<ResultShowProvider>(
          //   builder: (context, provider, _) {
          //     List<ExamResult> examResults = provider.examResults;
          //     return ListView.builder(
          //       itemCount: examResults.length,
          //       itemBuilder: (context, index) {
          //         ExamResult result = examResults[index];
          //         return ListTile(
          //           title: Text(result.title),
          //           subtitle: Text('Score: ${result.score}'),
          //         );
          //       },
          //     );
          //   },
          // ),

          Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xFF4042C9)),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    // {
                    //   Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (_) => LoginPage(),
                    //       ));
                    // },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: screenWidth * 0.18,
                ),
                Text(
                  "Exam Result ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  width: screenWidth * 0.15,
                ),
                Expanded(
                  child: PopupMenuItem(
                    child: IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showMenu(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the value as needed
                            side: BorderSide(
                                color: Colors
                                    .grey), // Add border color if necessary
                          ),
                          context: context,
                          position: RelativeRect.fromLTRB(82, 82, 0, 0),
                          items: [
                            PopupMenuItem(
                              child: Text('Exams'),
                              onTap: () {
                                Navigator.pushNamed(context, ExamHomeScreen);
                              },
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text('Logout'),
                              onTap: () async {
                                await UserPreferences.removeToken();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomePage(),
                                  ),
                                );
                              },
                              value: 2,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        itemCount: showResult.examResults.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          ExamResult result = showResult.examResults[index];
                          print(
                              'Number of questions: ${showResult.examResults.length}'); // Add this line

                          return InkWell(
                            onTap: () => {},
                            child: Card(
                              child: Container(
                                height: screenHeight * 0.2,
                                width: screenWidth * 0.94,
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: Colors.green, width: 5))),
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment
                                  // .start, // Align text to the left

                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      result.title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Score: ${result.score}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: screenHeight * 0.013),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          //  _examStart(question.id);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 77, 77, 79),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          side: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Text(
                                          'View',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
