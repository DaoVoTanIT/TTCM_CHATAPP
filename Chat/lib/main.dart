import 'package:chat/chats/presentation/screen/chats_Room.dart';
import 'package:chat/signinOrSignUp/presentation/screen/sigin.dart';
import 'package:chat/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'auth/services/auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Chat App',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        home: FutureBuilder(
          future: AuthService().getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ChatRoom();
            } else {
              return SignIn();
            }
          },
        )
        //         ? ChatRoom()
        //         : Authenticate()
        //   home: userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authenticate()
        //   : Container(
        // child: Center(
        //   child: Authenticate(),
        // ),
        // ),
        );
  }
}
