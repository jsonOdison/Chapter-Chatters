import 'package:book_app/screens/entry.dart';
import 'package:book_app/screens/home/home.dart';
import 'package:book_app/screens/login/login.dart';
import 'package:book_app/screens/group/noGroup/no_group.dart';
import 'package:book_app/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  unknown,
  notloggedIn,
  loggedIn,
  notInGroup,
  inGroup,
}

class MyRoot extends StatefulWidget {
  const MyRoot({super.key});

  @override
  State<MyRoot> createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  AuthStatus _authStatus = AuthStatus.loggedIn;

  Widget retVal = const LoginScreen();

  @override
  void didChangeDependencies() async {
    // ignore: todo
    //TODO : implement didChangeDependencies
    super.didChangeDependencies();
    //get the state

    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString = await currentUser.onStartUp();
    if (returnString == 'success') {
      if (currentUser.getUid?.groupId != null) {
        setState(() {
          _authStatus = AuthStatus.inGroup;
        });
      } else {
        setState(
          () {
            _authStatus = AuthStatus.notInGroup;
          },
        );
      }
    } else {
      setState(
        () {
          _authStatus = AuthStatus.notloggedIn;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.unknown:
        retVal = const Entry();
        break;
      case AuthStatus.loggedIn:
        retVal = const Entry();
        break;
      case AuthStatus.notloggedIn:
        retVal = const LoginScreen();
        break;
      case AuthStatus.notInGroup:
        retVal = const NoGroup();
        break;
      case AuthStatus.inGroup:
        retVal = const HomeScreen();
        break;
      default:
        retVal = const SizedBox(); // provide a default value for retVal
    }
    return retVal;
  }
}
