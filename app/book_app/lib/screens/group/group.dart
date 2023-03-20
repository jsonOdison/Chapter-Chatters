import 'package:book_app/screens/profile/localwidgets/profile_card.dart';
import 'package:book_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InGroup extends StatefulWidget {
  const InGroup({super.key});

  @override
  State<InGroup> createState() => _InGroupState();
}

class _InGroupState extends State<InGroup> {
  void show() async {
    var f = FirebaseAuth.instance;

    await Database().getUserInfo(f.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    show();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              const CustomCard(),
              SizedBox(
                height: 197.0,
                width: 358,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: const [
                        Text(
                          "Harry potter and the sorcerers Stone",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Due in : 8 days")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 197.0,
                width: 358,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: const [
                        Text(
                          "Book reveal in : ",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("24 hours")
                      ],
                    ),
                  ),
                ),
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text("Book club history"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
