import 'package:absoftexamination/pages/widget/awesomedialog.dart';
import 'package:absoftexamination/util/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Exam extends StatefulWidget {
  final dynamic examTitle, examSubject;
  const Exam({super.key, this.examTitle, this.examSubject});

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  @override
  void initState() {
    super.initState();
    print('=====:${widget.examTitle}');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kItemSelectBottomNav,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                buildDialog(
                    context,
                    "Warning!",
                    'Do you want to cancel this quiz? ',
                    DialogType.warning,
                    () => Navigator.pop(context),
                    () => null);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Column(
              children: <Widget>[
                Text(
                  widget.examTitle,
                  style: kHeadingTextStyleAppBar.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${widget.examSubject} Subject',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                )
                // Text(
                //   "Difficult: ${widget.difficult}",
                //   style: kHeadingTextStyleAppBar.copyWith(
                //       fontSize: 15,
                //       fontWeight: FontWeight.normal,
                //       color: Colors.white
                //   ),
                // ),
              ],
            )),
        body: Container(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 280,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: kItemSelectBottomNav),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Row(
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              // child: InkWell(
                              //   onTap: () {
                              //     // value.selectQuestion(e);
                              //   },
                              //   child: Padding(
                              //     padding: EdgeInsets.only(left: 15, right: 10),
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //         shape: BoxShape.circle,
                              //         // color: value.currentIndex == e ? Colors.grey[200] : Color(0xff7146ff),
                              //       ),
                              //       child: Center(
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(7),
                              //           child: Text(
                              //             'kkyyyyk',
                              //             style: TextStyle(
                              //                 // color: value.currentIndex == e ? Colors.black : Colors.white,
                              //                 fontWeight: FontWeight.bold),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                        scrollDirection: Axis.horizontal,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'What is ServiceNow system architecture?',
                          style: kHeadingTextStyleAppBar.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                  ),
                                  BoxShadow(
                                    offset: Offset(1, 1),
                                    color: Colors.grey,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RadioListTile(
                                    groupValue: 'iuuuu',
                                    activeColor: Colors.red,
                                    title: Text('Platform as a Service'),
                                    onChanged: (abc) {
                                      //value.selectRadio(e);
                                    },
                                    value: 'oi',
                                    //value: e,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RadioListTile(
                                    groupValue: 'iuuuu',
                                    activeColor: Colors.red,
                                    title: Text('Platform as a Service'),
                                    onChanged: (abc) {
                                      //value.selectRadio(e);
                                    },
                                    value: 'oi',
                                    //value: e,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RadioListTile(
                                    groupValue: 'iuuuu',
                                    activeColor: Colors.red,
                                    title: Text('Platform as a Service'),
                                    onChanged: (abc) {
                                      //value.selectRadio(e);
                                    },
                                    value: 'oi',
                                    //value: e,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFF3559E0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              child: Text(
                                'Answer',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPress() {
    return buildDialog(context, "Warning!", 'Do you want to cancel this quiz? ',
        DialogType.warning, () => Navigator.pop(context, true), () => null);
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Scaffold(
//   body: SingleChildScrollView(
//     child: Column(
//       children: [
//         ClipPath(
//           clipper: HomeClipper(),
//           child: Container(
//             width: screenWidth,
//             height: screenHeight * 0.4, // Adjust the height as needed
//             color: Color(0xFF4042C9),
//             padding: EdgeInsets.all(0),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: screenHeight *
//                       0.07, // Adjust the top position as needed
//                   right: 0,
//                   left: 0,
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/login');
//                         },
//                         icon: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(
//                         width: screenWidth *
//                             0.18, // Adjust the width as needed
//                       ),
//                       Text(
//                         'Select Subject',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                       SizedBox(
//                         width: screenWidth *
//                             0.15, // Adjust the width as needed
//                       ),
//                       PopupMenuItem(
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.more_horiz,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             showMenu(
//                               shape: Border.all(),
//                               context: context,
//                               position: RelativeRect.fromLTRB(82, 82, 0, 0),
//                               items: [
//                                 PopupMenuItem(
//                                   child: Center(
//                                     child: Text('Results'),
//                                   ),
//                                 ),
//                                 PopupMenuItem(
//                                   child: Center(
//                                     child: Text('Exams'),
//                                   ),
//                                 ),
//                                 PopupMenuItem(
//                                   child: Center(
//                                     child: Text('Logout'),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
