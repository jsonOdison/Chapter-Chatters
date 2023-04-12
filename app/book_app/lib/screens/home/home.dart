import 'package:book_app/screens/home/localwidgets/category_list/category_list.dart';
import 'package:flutter/material.dart';

import '../../helper/user_helper.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  String getFirstName(String res) {
    String firstName = res.substring(0, res.indexOf(" "));
    return firstName.substring(0, 1).toUpperCase() + firstName.substring(1);
  }

  gettingUserData() async {
    await HelperFunction.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String firstName = getFirstName(userName);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, $firstName !",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: textInputDecoration.copyWith(
                labelText: "search here..",
                prefixIcon: Icon(
                  Icons.search,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const CategoryList(),
          ],
        ),
      ),
    );
  }
}
