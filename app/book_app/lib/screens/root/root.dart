import 'package:book_app/screens/home/home.dart';
import 'package:book_app/screens/login/login.dart';
import 'package:book_app/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notloggedIn,
  loggedIn,
}

class MyRoot extends StatefulWidget {
  const MyRoot({super.key});

  @override
  State<MyRoot> createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  late AuthStatus _authStatus = AuthStatus.notloggedIn;

  Widget retVal = const LoginScreen();

  @override
  void didChangeDependencies() async {
    //TODO : implement didChangeDependencies
    super.didChangeDependencies();
    //get the state

    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString = await currentUser.onStartUp();
    if (returnString == 'success') {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notloggedIn:
        retVal = const LoginScreen();
        break;
      case AuthStatus.loggedIn:
        retVal = const HomeScreen();
        break;
      default:
        retVal = const SizedBox(); // provide a default value for retVal
    }
    return retVal;
  }
}
