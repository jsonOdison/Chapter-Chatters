import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({super.key});
  // void _gotoJoin() {}
  // void _gotoCreate() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff292731),
        leading: const IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
      ),
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
                    children: const [
                      ElevatedButton(
                        onPressed: null,
                        child: Text("Join"),
                      ),
                      ElevatedButton(
                        onPressed: null,
                        child: Text("Create"),
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
