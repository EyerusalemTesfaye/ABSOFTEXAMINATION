import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/providers/userProvider.dart';
import 'package:absoftexamination/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  dynamic userProvider;
  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.userData;
    print('User data: ${userProvider.userData?['email']}');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
              ),
            ),
            ClipPath(
              clipper: MyClipperSecond(),
              child: Container(
                height: 184,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFF07193F)),
              ),
            ),
            Positioned(
              top: 130,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: ClipPath(
                clipper: CircleClipper(),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.3,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: screenWidth * 0.2,
                  ),
                  Expanded(
                    child: PopupMenuItem(
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showMenu(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the value as needed
                              side: BorderSide(
                                  color: const Color.fromARGB(255, 245, 245,
                                      245)), // Add border color if necessary
                            ),
                            context: context,
                            position: RelativeRect.fromLTRB(82, 82, 0, 0),
                            items: [
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.list_alt,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Results',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                //onTap: () => _results(context),
                                value: 0,
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.perm_device_information,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'About Us',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  // fetchData();
                                },
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Column(
                                  children: [
                                    Divider(
                                      color:
                                          const Color.fromARGB(255, 62, 59, 59),
                                      thickness: 3.0,
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Logout',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
            ),
            Positioned(
              //top:255,
              top: screenHeight * 0.39,
              left: 0,
              width:
                  screenWidth, // Set the width to the full width of the screen
              child: Center(
                child: Text(
                  userProvider.userData?['fullname'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: screenHeight, // Adjust the height as needed
              child: Stack(
                children: <Widget>[
                  // // Other widgets in the Stack
                  Positioned(
                    top: 320,
                    left: screenWidth / 2 - 150,
                    right: 30,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 5, // Spread radius
                            blurRadius: 7, // Blur radius
                            offset: Offset(
                                0, 3), // Offset in x and y axes from the shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Email',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: screenWidth * 0.08,
                              ),
                              Text(
                                userProvider.userData?['email'] ??
                                    '', // Access email without curly braces
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                'Age',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: screenWidth * 0.08,
                              ),
                              Text(
                                userProvider.userData?['age'] ?? '',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                'Grade',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: screenWidth * 0.08,
                              ),
                              Text(
                                userProvider.userData?['grade'] ?? '',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 30),
                Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Row(
                        children: <Widget>[
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                          ),
                        ],
                      ),
                      scrollDirection: Axis.horizontal,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 70);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 70);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyClipperSecond extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
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

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
