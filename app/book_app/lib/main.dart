import 'package:book_app/screens/entry.dart';
import 'package:book_app/screens/login/login.dart';
import 'package:book_app/utils/constants.dart';
import 'package:book_app/utils/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'helper/user_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    //run the initilisation for web
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    // run the initilisation for andriod, ios
    await Firebase.initializeApp();
  }

  runApp(const BookApp());
}

class BookApp extends StatefulWidget {
  const BookApp({Key? key}) : super(key: key);

  @override
  State<BookApp> createState() => _BookAppState();
}

class _BookAppState extends State<BookApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));

    return MaterialApp(
      // routes: routes,
      debugShowCheckedModeBanner: false,
      title: 'welcome screen',
      theme: MainTheme().buildTheme(),
      home: _isSignedIn ? const Entry() : const LoginScreen(),
    );
  }
}
