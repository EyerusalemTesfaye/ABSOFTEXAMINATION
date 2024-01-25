import 'package:flutter/material.dart';

class Exam extends StatefulWidget {
  const Exam({super.key});

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 3, 33),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 61, 11, 240),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Absoft Exam Center',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4)
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              showMenu(
                shape: Border.all(color: Color.fromARGB(255, 61, 11, 240)),
                context: context,
                position: RelativeRect.fromLTRB(82, 82, 0, 0),
                items: [
                  PopupMenuItem(
                    child: Center(
                      child: Text(
                        'Results',
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 11, 240)),
                      ),
                    ),
                    value: '/result',
                  ),
                  PopupMenuItem(
                    child: Center(
                        child: Text(
                      'Exams',
                      style: TextStyle(color: Color.fromARGB(255, 61, 11, 240)),
                    )),
                    value: '/exam',
                  ),
                  PopupMenuItem(
                    child: Center(
                      child: Text(
                        'Logout',
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 11, 240)),
                      ),
                    ),
                    value: '/logout',
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'ffffffffffff',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';



// class Exam extends StatefulWidget {
//   // final List<Question> listQuestion;
//    final String title;
//   // final String difficult;

//   const Exam({ required this.title}) : super();

//   @override
//   _QuizPageState createState() => _QuizPageState();
// }


// class _QuizPageState extends State<Exam> {

//   @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   Provider.of<ScoreProvider>(context,listen: false).getAllScore();
//   //   print(widget.listQuestion.length);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     //List<int> listQuestionNumber = List<int>.generate(widget.listQuestion.length, (i) =>i  ); // convert array to int

//     return WillPopScope(
//       onWillPop:l,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xff1f12e5),
//           elevation: 0.0,
//           leading: IconButton(
//             onPressed: (){
//               // buildDialog(context, "Warning!", 'Do you want to cancel this quiz? '
//               //     , DialogType.WARNING, ()=>Navigator.pop(context),()=> null);
//             },
//             icon: Icon(Icons.arrow_back_ios),
//           ),
//           centerTitle: true,
//           title: Column(
//             children: <Widget>[

//               Text(widget.title,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   letterSpacing: 1.0,
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
              

//             ],
//           )
//         ),
//         body: Container(
//           width: double.infinity,
//           child: Stack(
//             children: <Widget>[
//               SizedBox(
//                 height: 20,
//               ),
//               ClipPath(
//                 clipper: MyClipper(),
//                 child: Container(
//                   height: 280,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 50, vertical: 50),
//                   width: MediaQuery
//                       .of(context)
//                       .size
//                       .width,
//                   decoration: BoxDecoration(
//                       color: Color(0xff1f12e5)
//                   ),
//                 ),
//               ),
//               Column(
//                 children: <Widget>[
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
                    
//                     child:               
//                        Column(
//                         children: <Widget>[
//                           Title(color: Colors.white, child: Text('hh')),
//                           SingleChildScrollView(
//                             child: Row(
//                               children: <Widget>[
//                                  SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   physics: BouncingScrollPhysics(),
//                                   child: InkWell(
//                                     // onTap: (){
//                                     //  value.selectQuestion(e);
//                                     // },
//                                     child: Padding(
//                                       padding: EdgeInsets.only(left: 15,right: 10),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color:  Colors.grey[200] : Color(0xff7146ff),
//                                         ),
//                                         child: Center(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(7),
//                                             child: Text(
//                                               'kkk',
//                                               style: TextStyle(
                                                  
//                                                 fontWeight: FontWeight.bold
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )
                                
//                               ],
//                             ),
//                             scrollDirection: Axis.horizontal,
//                           ),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//                             child: Text('gghghgggggggg'),style:
//                             TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 22
//                             ),),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20,),
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   width: double.infinity,
//                                   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(15),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.white,
//                                       ),
//                                       BoxShadow(
//                                         offset: Offset(10, 10),

//                                         color: Colors.grey,
//                                       ),
//                                       BoxShadow(
//                                         color: Colors.white,
//                                       ),
//                                     ],
//                                   ),
//                                   child:Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
                                      
//                                           RadioListTile(
//                                             groupValue: 'jjjj',
//                                             activeColor: Colors.red,
//                                             title: Text('hsdhjd'),
//                                             onChanged: (abc) {
                                              
//                                             }, value: 'hsfjhjhsdfjh',
                                            
//                                           ),
                                      
//                                     ],
//                                   ) ,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 25,
//                           ),
//                           Padding(
//                             child: Align(
//                               child: SizedBox(
//                                 width: 150,
//                                 child:ElevatedButton(
//                                   // shape: RoundedRectangleBorder(
//                                   //   borderRadius: BorderRadius.circular(10),
//                                   // ),
//                                   //style: ButtonStyle(colo),
//                                   onPressed: () {
                                
                                  
//                                   },
//                                   // child: Text(value.currentIndex == widget.listQuestion.length-1 ? "Submit" : "Next",
//                                   //   style: kHeadingTextStyleAppBar.copyWith(
//                                   //     color: Colors.white,
//                                   //     fontSize: 15,
//                                   //   ),) ,
//                                 ),
//                               ),
//                               alignment: Alignment.topRight,
//                             ),
//                             padding: EdgeInsets.symmetric(horizontal: 20),
//                           ),
//                         ],
//                       ),
//                     //  child: Text('jdjjd'),
            
            
                    
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Future<bool> onBackPress(){
//   //   return   buildDialog(context, "Warning!", 'Do you want to cancel this quiz? '
//   //       , DialogType.WARNING, ()=>Navigator.pop(context,true),()=>null);
//   // }
// }
// class MyClipper extends CustomClipper<Path>{
//   @override
//   Path getClip(Size size) {
//     // TODO: implement getClip
//     var path = Path();
//     path.lineTo(0.0, size.height -40);
//     path.quadraticBezierTo(size.width/4, size.height, size.width/2, size.height);
//     path.quadraticBezierTo(size.width- (size.width /4 ), size.height, size.width,size.height-40);
//     path.lineTo(size.width, 0.0);
    
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;

// }
