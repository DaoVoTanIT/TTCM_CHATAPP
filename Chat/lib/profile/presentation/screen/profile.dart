import 'package:chat/auth/services/auth.dart';
import 'package:chat/chats/presentation/widget/widget_chatRoom.dart';
import 'package:chat/profile/presentation/widget/numbers_widget.dart';
import 'package:chat/profile/presentation/widget/profile_Item.dart';
import 'package:chat/signinOrSignUp/presentation/screen/sigin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Color.fromRGBO(243, 245, 250, 1),
          //Colors.amberAccent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          AntDesign.arrowleft,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Log Out',
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                        title: 'Sign Out',
                                        descriptions:
                                            'Are you sure you want to Sign out?',
                                        yes: 'Yes',
                                        press: () {
                                          AuthService().signOut();
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignIn()));
                                        });
                                  });
                            },
                            child: Icon(
                              AntDesign.logout,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'My Profile',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 34,
                        //fontFamily: 'Nisebuschgardens',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      "${user?.displayName}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        //fontFamily: 'Nunito',
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${user?.email}",
                                      style: TextStyle(
                                        color: Colors.red[300],
                                        //fontFamily: 'Nunito',
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    NumbersWidget()
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  width: innerWidth * 0.45,
                                  height: 130,
                                  padding: EdgeInsets.only(
                                      left: 16, top: 25, right: 16),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              NetworkImage(user!.photoURL!))),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ProfileItem(
                            headerIcon: Icons.settings,
                            headerText: 'Setting',
                            onTap: () {},
                            text: '',
                            // mainIcon: ,
                          ),
                          Divider(
                            height: .5,
                            color: Colors.grey.withOpacity(.8),
                          ),
                          ProfileItem(
                            text: '',
                            headerIcon: Icons.notifications,
                            headerText: 'Notification',
                            onTap: () {},
                          ),
                          Divider(
                            height: .5,
                            color: Colors.grey.withOpacity(.8),
                          ),
                          ProfileItem(
                            text: '',
                            headerIcon: Icons.share,
                            headerText: 'Share Information Account',
                            // trailIcon: Icons.arrow_forward_ios_outlined,
                            onTap: () {},
                            //mainIcon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ProfileItem(
                            headerIcon: Icons.book_outlined,
                            headerText: 'Terms & conditions',
                            onTap: _launchURL,
                            text: '',
                            // mainIcon: ,
                          ),
                          Divider(
                            height: 0.5,
                            color: Colors.grey.withOpacity(.8),
                          ),
                          ProfileItem(
                            text: '',
                            headerIcon: Icons.contact_support_sharp,
                            headerText: 'Question & Answers',
                            // onTap: _launchURL,
                            onTap: () {},
                          ),
                          Divider(
                            height: .5,
                            color: Colors.grey.withOpacity(.8),
                          ),
                          ProfileItem(
                            text: '',
                            headerIcon: Icons.phone,
                            headerText: 'Contact',
                            // trailIcon: Icons.arrow_forward_ios_outlined,
                            onTap: () {},
                            //mainIcon: Icons.access_alarm_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _launchURL() async {
    //const url = 'https://flutterdevs.com/';
    const url = 'https://www.facebook.com/profile.php?id=100011448074609';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
