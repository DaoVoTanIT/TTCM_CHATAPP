import 'package:chat/auth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../background_painter.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  //CircularProgressIndicator(),
                  CustomPaint(painter: BackgroundPainter()),
                  buildSignIn(),
                ],
              ));
  }

  Widget buildSignIn() => Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: 175,
              child: Text(
                'Welcome Back To Chat App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // child: PrimaryButton(
            //     text: "Sign In with Google",
            //     press: () {
            //       AuthService().signInWithGoogle(context);
            //     }),
            child: OutlineButton.icon(
              label: Text(
                'Sign In With Google',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              highlightedBorderColor: Colors.black,
              borderSide: BorderSide(color: Colors.black),
              textColor: Colors.black,
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
              onPressed: () {
                AuthService().signInWithGoogle(context);
              },
            ),
          ),
          Spacer(),
        ],
      );
}
