import 'package:book_app/screens/root/root.dart';
import 'package:book_app/states/current_user.dart';
import 'package:book_app/utils/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'welcome screen',
        theme: MainTheme().buildTheme(),
        home: const MyRoot(),
      ),
    );
  }
}
