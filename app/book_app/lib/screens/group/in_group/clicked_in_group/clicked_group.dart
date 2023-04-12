import 'package:book_app/screens/profile/localwidgets/profile_card.dart';
import 'package:flutter/material.dart';

class InGroup extends StatelessWidget {
  const InGroup({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
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
