import 'package:absoftexamination/pages/home.dart';
import 'package:absoftexamination/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/profile.png'),
                    fit: BoxFit.cover)),
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
                // ColorFiltered(
                //   colorFilter:
                //       ColorFilter.mode(Colors.white, BlendMode.srcIn),
                //   child: Image(
                //     width: 50,
                //     height: 50,
                //     image: AssetImage('assets/quizer_logo.png'),
                //   ),
                // ),

                SizedBox(
                  width: screenWidth * 0.3,
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  width: screenWidth * 0.25,
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
                                    Icons.person_outline,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Profile',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, UserProfileScreen);
                                //fetchData();
                              },
                              value: 1,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
              left: 170,
              right: 100,
              top: 300,
              child: Text(
                'hey',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ))
        ],
      ),
    );
  }
}
