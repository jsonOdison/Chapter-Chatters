import 'package:book_app/screens/group/create_group/create_group.dart';
import 'package:book_app/screens/group/search_group/search_group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({super.key});

  @override
  Widget build(BuildContext context) {
    void gotoJoin(BuildContext context) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SearchGroup()));
    }

    void gotoCreate(BuildContext context) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CreateGroup()));
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Text(
                "Welcome to the book club :",
                style: GoogleFonts.newsreader(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 40),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Since youre not in a group yet , You can either Join one , or create one on your own",
                style: GoogleFonts.newsreader(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 100,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => gotoJoin(context),
                        child: const Text("Join"),
                      ),
                      ElevatedButton(
                        onPressed: () => gotoCreate(context),
                        child: const Text("Create"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
