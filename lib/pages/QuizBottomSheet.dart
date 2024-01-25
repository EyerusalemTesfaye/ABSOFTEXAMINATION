import 'package:flutter/material.dart';

class QuizBottomSheet extends StatefulWidget {
  final String title;
  final String subTitle;

  const QuizBottomSheet({required this.title, required this.subTitle})
      : super();

  @override
  _QuizBottomSheetState createState() => _QuizBottomSheetState();
}

class _QuizBottomSheetState extends State<QuizBottomSheet> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("English Subject"),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(widget.subTitle),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF3559E0)),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white) // Change to your desired color
                    ),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  Navigator.pushNamed(context, '/exam',
                      arguments: widget.title);
                },
                child: Text(
                  "Start Exam",
                  style: TextStyle(
                    fontSize: 16,
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
